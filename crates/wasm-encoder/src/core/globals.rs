use crate::{encode_section, Encode, Instruction, Section, SectionId, ValType};

/// An encoder for the global section.
///
/// Global sections are only supported for modules.
///
/// # Example
///
/// ```
/// use wasm_encoder::{Module, GlobalSection, GlobalType, Instruction, ValType};
///
/// let mut globals = GlobalSection::new();
/// globals.global(
///     GlobalType {
///         val_type: ValType::I32,
///         mutable: false,
///     },
///     &Instruction::I32Const(42),
/// );
///
/// let mut module = Module::new();
/// module.section(&globals);
///
/// let wasm_bytes = module.finish();
/// ```
#[derive(Clone, Default, Debug)]
pub struct GlobalSection {
    bytes: Vec<u8>,
    num_added: u32,
}

impl GlobalSection {
    /// Create a new global section encoder.
    pub fn new() -> Self {
        Self::default()
    }

    /// The number of globals in the section.
    pub fn len(&self) -> u32 {
        self.num_added
    }

    /// Determines if the section is empty.
    pub fn is_empty(&self) -> bool {
        self.num_added == 0
    }

    /// Define a global.
    pub fn global(&mut self, global_type: GlobalType, init_expr: &Instruction<'_>) -> &mut Self {
        global_type.encode(&mut self.bytes);
        init_expr.encode(&mut self.bytes);
        Instruction::End.encode(&mut self.bytes);
        self.num_added += 1;
        self
    }

    /// Add a raw byte slice into this code section as a global.
    pub fn raw(&mut self, data: &[u8]) -> &mut Self {
        self.bytes.extend(data);
        self.num_added += 1;
        self
    }
}

impl Encode for GlobalSection {
    fn encode(&self, sink: &mut Vec<u8>) {
        encode_section(sink, SectionId::Global, self.num_added, &self.bytes);
    }
}

impl Section for GlobalSection {}

/// A global's type.
#[derive(Clone, Copy, Debug, Eq, PartialEq)]
pub struct GlobalType {
    /// This global's value type.
    pub val_type: ValType,
    /// Whether this global is mutable or not.
    pub mutable: bool,
}

impl Encode for GlobalType {
    fn encode(&self, sink: &mut Vec<u8>) {
        sink.push(self.val_type.into());
        sink.push(self.mutable as u8);
    }
}