:o:MapRenderer:c:postinit {
    raw_segments = [seg.pos for seg in self.engine.level_data.raw_segments];
    (self.x_min, self.y_min, self.x_max, self.y_max) = self.get_bounds(raw_segments);
    self.raw_segments = self.remap_array(raw_segments);
}

:o:MapRenderer:c:draw {
    self.draw_segments();
}

:o:MapRenderer:c:draw_segments {
    for (p0, p1) in self.raw_segments {
        ((x0, y0), (x1, y1)) = (p0, p1);
        ray.draw_line_v((x0, y0), (x1, y1), ray.ORANGE);
        ray.draw_circle((x0, y0), 3, ray.RED);
    }
}

:o:MapRenderer:c:remap_array {
    return [(self.remap_vec2(p0), self.remap_vec2(p1)) for (p0, p1) in arr];
}

:o:MapRenderer:c:remap_vec2 {
    return glm.vec2(self.remap_x(vec.x), self.remap_y(vec.y));
}

:o:MapRenderer:c:remap_x
(x: float, out_min: float=MAP_OFFSET, out_max: float=MAP_WIDTH) -> float {
    return (x - self.x_min) * (out_max - out_min) / (self.x_max - self.x_min) + out_min;
}

:o:MapRenderer:c:remap_y
(y: float, out_min: float=MAP_OFFSET, out_max: float=MAP_HEIGHT) -> float {
    return (y - self.y_min) * (out_max - out_min) / (self.y_max - self.y_min) + out_min;
}

:o:MapRenderer:c:get_bounds {
    inf = float('inf');
    (x_min, y_min, x_max, y_max) = (inf, inf, -inf, -inf);
    for (p0, p1) in segments {
        x_min = p0.x if p0.x < x_min else p1.x if p1.x < x_min else x_min;
        x_max = p0.x if p0.x > x_max else p1.x if p1.x > x_max else x_max;
        y_min = p0.y if p0.y < y_min else p1.y if p1.y < y_min else y_min;
        y_max = p0.y if p0.y > y_max else p1.y if p1.y > y_max else y_max;
    }
    return (x_min, y_min, x_max, y_max);
}
