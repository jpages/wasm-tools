(component
  (type (;0;)
    (instance
      (export (;0;) "logger" (type (sub resource)))
      (type (;1;) (borrow 0))
      (type (;2;) (func (param "self" 1) (param "message" string)))
      (export (;0;) "[method]logger.log" (func (type 2)))
      (type (;3;) (own 0))
      (type (;4;) (func (result 3)))
      (export (;1;) "get-logger" (func (type 4)))
    )
  )
  (import "example:service/logging@0.1.0" (instance (;0;) (type 0)))
  (component (;0;)
    (type (;0;)
      (instance
        (export (;0;) "logger" (type (sub resource)))
        (type (;1;) (borrow 0))
        (type (;2;) (func (param "self" 1) (param "message" string)))
        (export (;0;) "[method]logger.log" (func (type 2)))
        (type (;3;) (own 0))
        (type (;4;) (func (result 3)))
        (export (;1;) "get-logger" (func (type 4)))
      )
    )
    (import "example:service/logging@0.1.0" (instance (;0;) (type 0)))
  )
  (component (;1;)
    (type (;0;)
      (instance
        (export (;0;) "logger" (type (sub resource)))
        (type (;1;) (borrow 0))
        (type (;2;) (func (param "self" 1) (param "message" string)))
        (export (;0;) "[method]logger.log" (func (type 2)))
        (type (;3;) (own 0))
        (type (;4;) (func (result 3)))
        (export (;1;) "get-logger" (func (type 4)))
      )
    )
    (import "example:service/logging@0.1.0" (instance $import-logging-instance (;0;) (type 0)))
    (core module $module (;0;)
      (type (;0;) (func (param i32 i32 i32)))
      (type (;1;) (func (result i32)))
      (type (;2;) (func (param i32) (result i32)))
      (type (;3;) (func (param i32 i32 i32 i32) (result i32)))
      (import "example:service/logging@0.1.0" "[method]logger.log" (func (;0;) (type 0)))
      (import "example:service/logging@0.1.0" "get-logger" (func (;1;) (type 1)))
      (import "[export]example:service/logging@0.1.0" "[resource-new]logger" (func (;2;) (type 2)))
      (func $cabi_realloc (;3;) (type 3) (param i32 i32 i32 i32) (result i32)
        unreachable
      )
      (func $logger-log (;4;) (type 0) (param i32 i32 i32)
        unreachable
      )
      (func $get-logger (;5;) (type 1) (result i32)
        unreachable
      )
      (memory $memory (;0;) 1)
      (export "memory" (memory $memory))
      (export "cabi_realloc" (func $cabi_realloc))
      (export "example:service/logging@0.1.0#[method]logger.log" (func $logger-log))
      (export "example:service/logging@0.1.0#get-logger" (func $get-logger))
    )
    (core module $module-indirect (;1;)
      (type (;0;) (func (param i32 i32 i32)))
      (type (;1;) (func (result i32)))
      (type (;2;) (func (param i32)))
      (func $logger-log (;0;) (type 0) (param i32 i32 i32)
        unreachable
      )
      (func $get-logger (;1;) (type 1) (result i32)
        unreachable
      )
      (func $dtor-logger (;2;) (type 2) (param i32)
        unreachable
      )
      (export "logger.log" (func $logger-log))
      (export "[dtor]logger" (func $dtor-logger))
    )
    (core instance $module-indirect-instance (;0;) (instantiate $module-indirect))
    (alias export $import-logging-instance "logger" (type $import-logger-type (;1;)))
    (core func $import-drop-logger (;0;) (canon resource.drop $import-logger-type))
    (alias core export $module-indirect-instance "logger.log" (core func $import-logger-log (;1;)))
    (alias export $import-logging-instance "get-logger" (func $import-get-logger (;0;)))
    (core func $import-get-logger-lowered (;2;) (canon lower (func $import-get-logger)))
    (core instance $logger-impl-instance (;1;)
      (export "[resource-drop]logger" (func $import-drop-logger))
      (export "[method]logger.log" (func $import-logger-log))
      (export "get-logger" (func $import-get-logger-lowered))
    )
    (alias core export $module-indirect-instance "[dtor]logger" (core func $logger-dtor (;3;)))
    (type $logger-resource (;2;) (resource (rep i32) (dtor (func $logger-dtor))))
    (core func $logger-new (;4;) (canon resource.new $logger-resource))
    (core instance $logger-new-instance (;2;)
      (export "[resource-new]logger" (func $logger-new))
    )
    (core instance $module-instance (;3;) (instantiate $module
        (with "example:service/logging@0.1.0" (instance $logger-impl-instance))
        (with "[export]example:service/logging@0.1.0" (instance $logger-new-instance))
      )
    )
    (alias core export $module-instance "memory" (core memory $memory (;0;)))
    (alias core export $module-instance "cabi_realloc" (core func $realloc (;5;)))
    (type (;3;) (borrow $logger-resource))
    (type $logger-log-type (;4;) (func (param "self" 3) (param "message" string)))
    (alias core export $module-instance "example:service/logging@0.1.0#[method]logger.log" (core func $logger-log (;6;)))
    (func $logger-log-lifted (;1;) (type $logger-log-type) (canon lift (core func $logger-log) (memory $memory) (realloc $realloc) string-encoding=utf8))
    (alias core export $module-instance "example:service/logging@0.1.0#get-logger" (core func $get-logger (;7;)))
    (type (;5;) (own $logger-resource))
    (type $get-logger-type (;6;) (func (result 5)))
    (func $get-logger-lifted (;2;) (type $get-logger-type) (canon lift (core func $get-logger)))
    (component $logger (;0;)
      (import "import-type-logger" (type $import-logger (;0;) (sub resource)))
      (type (;1;) (borrow $import-logger))
      (type (;2;) (func (param "self" 1) (param "message" string)))
      (import "import-method-logger-log" (func $import-logger-log (;0;) (type 2)))
      (type (;3;) (own $import-logger))
      (type (;4;) (func (result 3)))
      (import "import-func-get-logger" (func $import-get-logger (;1;) (type 4)))
      (export $logger (;5;) "logger" (type $import-logger))
      (type (;6;) (borrow $logger))
      (type (;7;) (func (param "self" 6) (param "message" string)))
      (export (;2;) "[method]logger.log" (func $import-logger-log) (func (type 7)))
      (type (;8;) (own $logger))
      (type (;9;) (func (result 8)))
      (type (;10;) (own $logger))
      (type (;11;) (func (result 10)))
      (export (;3;) "get-logger" (func $import-get-logger) (func (type 11)))
    )
    (instance $logger-instance (;1;) (instantiate $logger
        (with "import-method-logger-log" (func $logger-log-lifted))
        (with "import-func-get-logger" (func $get-logger-lifted))
        (with "import-type-logger" (type $logger-resource))
      )
    )
    (export (;2;) "example:service/logging@0.1.0" (instance $logger-instance))
  )
  (instance (;1;) (instantiate 1
      (with "example:service/logging@0.1.0" (instance 0))
    )
  )
  (alias export 1 "example:service/logging@0.1.0" (instance (;2;)))
  (instance (;3;) (instantiate 0
      (with "example:service/logging@0.1.0" (instance 2))
    )
  )
)