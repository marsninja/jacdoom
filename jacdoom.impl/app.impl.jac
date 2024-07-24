:o:App:c:postinit {
    self.engine = Engine(app=self);
}

:o:App:c:run {
    while not ray.window_should_close() {
        self.dt = ray.get_frame_time();
        self.engine.update();
        self.engine.draw();
    }
    ray.close_window();
}
