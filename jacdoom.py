from __future__ import annotations
from typing import TYPE_CHECKING
from jaclang import jac_import as __jac_import__
from jaclang.plugin.feature import JacFeature as _Jac
from jaclang.plugin.builtin import *
from dataclasses import dataclass as __jac_dataclass__
from dataclasses import field as __jac_field__

if TYPE_CHECKING:
    import pyray as ray, glm
else:
    (ray,) = __jac_import__(
        target="pyray",
        base_path=__file__,
        mod_bundle=__name__,
        lng="py",
        absorb=False,
        mdl_alias="ray",
        items={},
    )
    (glm,) = __jac_import__(
        target="glm",
        base_path=__file__,
        mod_bundle=__name__,
        lng="py",
        absorb=False,
        mdl_alias=None,
        items={},
    )
if TYPE_CHECKING:
    from settings import WIN_WIDTH, WIN_HEIGHT
else:
    WIN_WIDTH, WIN_HEIGHT = __jac_import__(
        target="settings",
        base_path=__file__,
        mod_bundle=__name__,
        lng="jac",
        absorb=False,
        mdl_alias=None,
        items={"WIN_WIDTH": None, "WIN_HEIGHT": None},
    )
if TYPE_CHECKING:
    from level import SEGMENTS
else:
    (SEGMENTS,) = __jac_import__(
        target="level",
        base_path=__file__,
        mod_bundle=__name__,
        lng="jac",
        absorb=False,
        mdl_alias=None,
        items={"SEGMENTS": None},
    )


@_Jac.make_obj(on_entry=[], on_exit=[])
@__jac_dataclass__(eq=False)
class Segment(_Jac.Obj):
    start: glm.Vec2
    end: glm.Vec2


@_Jac.make_obj(on_entry=[], on_exit=[])
@__jac_dataclass__(eq=False)
class Level(_Jac.Obj):
    segments: list[Segment] = _Jac.has_instance_default(
        gen_func=lambda: [
            Segment(start=glm.vec2(start), end=glm.vec2(end)) for start, end in SEGMENTS
        ]
    )


@_Jac.make_obj(on_entry=[], on_exit=[])
@__jac_dataclass__(eq=False)
class Engine(_Jac.Obj):
    app: App

    def update(self) -> None:
        pass

    def draw_2d(self) -> None:
        pass

    def draw_3d(self) -> None:
        pass

    def draw(self) -> None:
        ray.begin_drawing()
        ray.clear_background(ray.BLACK)
        self.draw_3d()
        self.draw_2d()
        ray.end_drawing()


@_Jac.make_obj(on_entry=[], on_exit=[])
@__jac_dataclass__(eq=False)
class App(_Jac.Obj):
    engine: Engine = __jac_field__(init=False)
    dt: float = _Jac.has_instance_default(gen_func=lambda: 0.0)

    def __post_init__(self) -> None:
        self.engine = Engine(app=self)

    def run(self) -> None:
        while not ray.window_should_close():
            self.dt = ray.get_frame_time()
            self.engine.update()
            self.engine.draw()
        ray.close_window()


if __name__ == "__main__":
    ray.init_window(WIN_WIDTH, WIN_HEIGHT, "Jac Doom")
    app = App()
    app.run()
