:o:Engine:c:update {}

:o:Engine:c:draw_2d {}

:o:Engine:c:draw_3d {}

:o:Engine:c:draw {
    ray.begin_drawing();
    ray.clear_background(ray.BLACK);
    self.draw_3d();
    self.draw_2d();
    ray.end_drawing();
}
