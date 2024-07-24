import glm;

glob P = [(1.0, 1.0), (7.0, 1.0), (7.0, 8.0), (1.0, 8.0)];

glob SEGMENTS: list[tuple[tuple[float, float], tuple[float, float]]] = [(P[0], P[1]), (P[1], P[2]), (P[2], P[3]), (P[3], P[0])];
