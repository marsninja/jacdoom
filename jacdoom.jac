import pyray as ray, glm;
import from settings { WIN_WIDTH, WIN_HEIGHT }
import from level { SEGMENTS }

obj Segment;

obj LevelData;

obj Engine {
    has app: App;

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
