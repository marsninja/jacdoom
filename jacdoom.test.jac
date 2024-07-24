test level_data {
    ld = str(LevelData());
    check assertIn("LevelData(segments=[Segment(start=vec2(", ld);
}
