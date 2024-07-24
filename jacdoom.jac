import pyray as ray, glm;
import from settings { WIN_WIDTH, WIN_HEIGHT, MAP_WIDTH, MAP_HEIGHT, MAP_OFFSET }
import from level { SEGMENTS }

obj Segment {
    has pos: tuple[glm.Vec2, glm.Vec2];
}

obj LevelData {
    has engine: Engine,
        raw_segments: list[Segment] = [Segment((glm.vec2(start), glm.vec2(end))) for (start, end) in SEGMENTS];
}

obj MapRenderer {
    has engine: Engine;
    has x_min: float = 0.0,
        x_max: float = 0.0,
        y_min: float = 0.0,
        y_max: float = 0.0;

    can postinit;
    can draw;
    can draw_segments;
    can remap_array(arr: list[glm.Vec2]) -> list[glm.Vec2];
    can remap_vec2(vec: glm.Vec2) -> glm.Vec2;
    can remap_x(x: float, out_min: float=MAP_OFFSET, out_max: float=MAP_WIDTH) -> float;
    can remap_y(y: float, out_min: float=MAP_OFFSET, out_max: float=MAP_HEIGHT) -> float;
    static can get_bounds(segments: list[tuple[glm.Vec2, glm.Vec2]]) -> tuple[float, float, float, float];
}

obj Engine {
    has app: App;
    has level_data: LevelData by postinit,
        map_renderer: MapRenderer by postinit;

    can postinit;
    can update;
    can draw_2d;
    can draw_3d;
    can draw;
}

obj App {
    has engine: Engine by postinit;
    has dt: float = 0.0;

    can postinit;
    can run;
}

with entry:__main__ {
    ray.init_window(WIN_WIDTH, WIN_HEIGHT, "Jac Doom");
    app = App();
    app.run();
}
