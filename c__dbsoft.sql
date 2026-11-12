-- 1. 플레이어 테이블 (PLAYER)
CREATE TABLE PLAYER (
    player_id   VARCHAR2(36)  NOT NULL,
    nickname    VARCHAR2(50)  NOT NULL,
    tag         VARCHAR2(10)  NOT NULL,
    CONSTRAINT PK_PLAYER PRIMARY KEY (player_id),
    CONSTRAINT UQ_PLAYER_NICK_TAG UNIQUE (nickname, tag)
);

-- 2. 팀 테이블 (TEAM)
CREATE TABLE TEAM (
    team_id     VARCHAR2(36)  NOT NULL,
    team_name   VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_TEAM PRIMARY KEY (team_id)
);

-- 3. 소속 테이블 (TEAM_MEMBER)
CREATE TABLE TEAM_MEMBER (
    player_id   VARCHAR2(36)  NOT NULL,
    team_id     VARCHAR2(36)  NOT NULL,
    join_date   DATE          NOT NULL,
    CONSTRAINT PK_TEAM_MEMBER PRIMARY KEY (player_id, team_id),
    CONSTRAINT FK_TEAM_MEMBER_PLAYER FOREIGN KEY (player_id) REFERENCES PLAYER(player_id),
    CONSTRAINT FK_TEAM_MEMBER_TEAM   FOREIGN KEY (team_id)   REFERENCES TEAM(team_id)
);

-- 4. 맵 테이블 (MAP)
CREATE TABLE MAP (
    map_id      NUMBER        GENERATED ALWAYS AS IDENTITY NOT NULL,
    map_name    VARCHAR2(50)  NOT NULL,
    map_type    VARCHAR2(30)  NOT NULL,
    CONSTRAINT PK_MAP PRIMARY KEY (map_id)
);

-- 5. 에이전트 테이블 (AGENT)
CREATE TABLE AGENT (
    agent_id    NUMBER        GENERATED ALWAYS AS IDENTITY NOT NULL,
    agent_name  VARCHAR2(50)  NOT NULL,
    role        VARCHAR2(30)  NOT NULL,
    CONSTRAINT PK_AGENT PRIMARY KEY (agent_id)
);

-- 6. 시즌 테이블 (SEASON)
CREATE TABLE SEASON (
    season_id   NUMBER        GENERATED ALWAYS AS IDENTITY NOT NULL,
    season_name VARCHAR2(50)  NOT NULL,
    start_date  DATE          NOT NULL,
    end_date    DATE          NOT NULL,
    CONSTRAINT PK_SEASON PRIMARY KEY (season_id)
);

-- 7. 무기 테이블 (WEAPON)
CREATE TABLE WEAPON (
    weapon_id   NUMBER        GENERATED ALWAYS AS IDENTITY NOT NULL,
    weapon_name VARCHAR2(50)  NOT NULL,
    weapon_type VARCHAR2(30)  NOT NULL,
    CONSTRAINT PK_WEAPON PRIMARY KEY (weapon_id)
);

-- 8. 경기 테이블 (MATCH)
CREATE TABLE MATCH (
    match_id     VARCHAR2(36) NOT NULL,
    map_id       NUMBER       NOT NULL,
    season_id    NUMBER       NOT NULL,
    match_date   DATE         NOT NULL,
    match_mode   VARCHAR2(30) NOT NULL,
    duration     NUMBER       NOT NULL,
    team_a_score NUMBER       DEFAULT 0 NOT NULL,
    team_b_score NUMBER       DEFAULT 0 NOT NULL,
    CONSTRAINT PK_MATCH PRIMARY KEY (match_id),
    CONSTRAINT FK_MATCH_MAP    FOREIGN KEY (map_id)    REFERENCES MAP(map_id),
    CONSTRAINT FK_MATCH_SEASON FOREIGN KEY (season_id) REFERENCES SEASON(season_id),
    CONSTRAINT CK_MATCH_MODE   CHECK (match_mode IN ('Unranked', 'Competitive')),
    CONSTRAINT CK_MATCH_SCORE_A CHECK (team_a_score >= 0),
    CONSTRAINT CK_MATCH_SCORE_B CHECK (team_b_score >= 0)
);

-- 9. 팀참가 테이블 (MATCH_TEAM)
CREATE TABLE MATCH_TEAM (
    match_id    VARCHAR2(36)  NOT NULL,
    team_id     VARCHAR2(36)  NOT NULL,
    team_side   VARCHAR2(10)  NOT NULL,
    result      VARCHAR2(10)  NOT NULL,
    CONSTRAINT PK_MATCH_TEAM PRIMARY KEY (match_id, team_id),
    CONSTRAINT FK_MATCH_TEAM_MATCH FOREIGN KEY (match_id) REFERENCES MATCH(match_id),
    CONSTRAINT FK_MATCH_TEAM_TEAM  FOREIGN KEY (team_id)  REFERENCES TEAM(team_id),
    CONSTRAINT CK_MATCH_TEAM_SIDE  CHECK (team_side IN ('BLUE', 'RED')),
    CONSTRAINT CK_MATCH_TEAM_RES   CHECK (result IN ('WIN', 'LOSE', 'DRAW'))
);

-- 10. 플레이어참가 테이블 (MATCH_PLAYER)
CREATE TABLE MATCH_PLAYER (
    match_id    VARCHAR2(36)  NOT NULL,
    player_id   VARCHAR2(36)  NOT NULL,
    team_id     VARCHAR2(36)  NULL,
    team_side   VARCHAR2(10)  NOT NULL,
    agent_id    NUMBER        NOT NULL,
    kills       NUMBER        DEFAULT 0 NOT NULL,
    deaths      NUMBER        DEFAULT 0 NOT NULL,
    assists     NUMBER        DEFAULT 0 NOT NULL,
    CONSTRAINT PK_MATCH_PLAYER PRIMARY KEY (match_id, player_id),
    CONSTRAINT FK_MATCH_PLAYER_MATCH  FOREIGN KEY (match_id)  REFERENCES MATCH(match_id),
    CONSTRAINT FK_MATCH_PLAYER_PLAYER FOREIGN KEY (player_id) REFERENCES PLAYER(player_id),
    CONSTRAINT FK_MATCH_PLAYER_TEAM   FOREIGN KEY (team_id)   REFERENCES TEAM(team_id),
    CONSTRAINT FK_MATCH_PLAYER_AGENT  FOREIGN KEY (agent_id)  REFERENCES AGENT(agent_id),
    CONSTRAINT CK_MATCH_PLAYER_SIDE   CHECK (team_side IN ('BLUE', 'RED')),
    CONSTRAINT CK_MATCH_PLAYER_KILLS  CHECK (kills >= 0),
    CONSTRAINT CK_MATCH_PLAYER_DEATHS CHECK (deaths >= 0),
    CONSTRAINT CK_MATCH_PLAYER_ASSIST CHECK (assists >= 0)
);

-- 11. 무기사용 테이블 (WEAPON_USAGE)
CREATE TABLE WEAPON_USAGE (
    match_id    VARCHAR2(36)  NOT NULL,
    player_id   VARCHAR2(36)  NOT NULL,
    weapon_id   NUMBER        NOT NULL,
    kill_count  NUMBER        DEFAULT 0 NOT NULL,
    shot_count  NUMBER        DEFAULT 0 NOT NULL,
    hit_count   NUMBER        DEFAULT 0 NOT NULL,
    CONSTRAINT PK_WEAPON_USAGE PRIMARY KEY (match_id, player_id, weapon_id),
    CONSTRAINT FK_WEAPON_USAGE_MATCH  FOREIGN KEY (match_id)  REFERENCES MATCH(match_id),
    CONSTRAINT FK_WEAPON_USAGE_PLAYER FOREIGN KEY (player_id) REFERENCES PLAYER(player_id),
    CONSTRAINT FK_WEAPON_USAGE_WEAPON FOREIGN KEY (weapon_id) REFERENCES WEAPON(weapon_id),
    CONSTRAINT CK_WEAPON_USAGE_KILL   CHECK (kill_count >= 0),
    CONSTRAINT CK_WEAPON_USAGE_SHOT   CHECK (shot_count >= 0),
    CONSTRAINT CK_WEAPON_USAGE_HIT    CHECK (hit_count >= 0),
    CONSTRAINT CK_WEAPON_USAGE_ACC    CHECK (hit_count <= shot_count)
);