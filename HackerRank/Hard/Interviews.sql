SELECT view_sq.contest_id, view_sq.hacker_id, view_sq.name, sub_sq.sum_ts, sub_sq.sum_tas, view_sq.sum_tv, view_sq.sum_tuv FROM
(
    SELECT con.contest_id, con.hacker_id, con.name, SUM(vs.total_views) AS sum_tv, SUM(vs.total_unique_views) AS sum_tuv FROM contests AS con
    JOIN colleges AS col ON con.contest_id = col.contest_id
    JOIN challenges AS cha ON col.college_id = cha.college_id
    JOIN view_stats AS vs ON cha.challenge_id = vs.challenge_id
    GROUP BY con.contest_id, con.hacker_id, con.name
) AS view_sq
JOIN (
    SELECT con.contest_id, con.hacker_id, con.name, SUM(total_submissions) AS sum_ts, SUM(total_accepted_submissions) AS sum_tas FROM contests AS con
    JOIN colleges AS col ON con.contest_id = col.contest_id
    JOIN challenges AS cha ON col.college_id = cha.college_id
    JOIN submission_stats AS ss ON cha.challenge_id = ss.challenge_id
    GROUP BY con.contest_id, con.hacker_id, con.name
) AS sub_sq ON view_sq.contest_id=sub_sq.contest_id
WHERE view_sq.sum_tv+view_sq.sum_tuv+sub_sq.sum_ts+sub_sq.sum_tas>0
ORDER BY view_sq.contest_id;