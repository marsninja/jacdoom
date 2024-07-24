:o:Segment  {
    has start: glm.Vec2,
        end: glm.Vec2;
}

:o:Level  {
    has segments: list[Segment] = [Segment(start=glm.vec2(start), end=glm.vec2(end)) for (start, end) in SEGMENTS];
}
