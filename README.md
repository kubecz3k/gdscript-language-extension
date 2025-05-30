
# ClassUtils

ClassUtils is a Godot Engine **singleton** designed to extend GDScript with features currently unavailable natively, specifically focused on **enforcing abstract function implementations**.

## Features

* **Abstract Function Checking**: Automatically identifies if concrete classes fail to implement abstract functions defined in their abstract parent classes.

## How to Use

1.  **Add as a Singleton**: Add `class_utils.tscn` as a singleton in your Godot project settings.
2.  **Mark Abstract Classes**: Above your abstract class's `class_name` declaration, add the line:
    ```gdscript
    "@abstract_class"
    class_name MyAbstractClass
    extends Node
    ```
3.  **Mark Abstract Functions**: Inside the body of any abstract function, add the following assertion:
    ```gdscript
    func my_abstract_function():
        assert(false, ClassUtils.ABSTRACT_FUNCTION_MSG)
        # Your abstract function logic (if any default behavior is desired)
    ```

## Author

Jakub Grzesik

## Origin

Originally implemented for the needs of [MSEP-one](https://github.com/MSEP-one/msep.one).

---
