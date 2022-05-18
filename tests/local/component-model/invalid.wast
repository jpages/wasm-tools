(assert_invalid
  (component
    (type (module
      (import "" "" (func (type 1)))
    ))
    (type (func))
  )
  "type index out of bounds")

(assert_invalid
  (component
    (import "" (func $f))
    (component
      (alias outer 1 $f (func $f))
    )
  )
  "invalid leading byte")

(assert_malformed
  (module quote
    "(component"
      "(export \"\" (func $foo))"
    ")"
  )
  "failed to find func named")

(assert_malformed
  (module quote
    "(component"
      "(alias outer 100 $foo (func $foo))"
    ")"
  )
  "component depth of `100` is too large")

(assert_malformed
  (module quote
    "(component"
      "(alias outer $nonexistent $foo (func $foo))"
    ")"
  )
  "outer component `nonexistent` not found")