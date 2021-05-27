Real = {}
Real.Locale = 'en'

Real.Settings = {
    Key = 38,

    minSellPrice = 50,
    maxSellPrice = 100,

    minSalaryIncrease = 50,
    maxSalaryIncrease = 100,

    marker = {
        toggle = true,

        type = 20,
        scale = {x = 0.4, y = 0.4, z = 0.2},
        color = {r = 150, g = 0, b = 0, a = 255},
        upAndDown = false,
        faceCamera = true,
        rotate = false,
    },

    drawTxt = {
        toggle = true,

        scale = {0.35, 0.35},
        font = 4,
        proportional = 1,
        color = {r=255, g=255, b=255, a=215}
    },
}

Real.Company = {
    coords = {
        vector3(68.97, -1569.97, 29.6),
    },

    ped = {
        toggle = true,
        model = 'cs_barry'
    },
}

Real.Customers = {
    vector4(-1507.806,   -933.769,    9.722,    152.740),
    vector4(-1468.622,   -967.111,    7.172,    131.986),
    vector4(-1488.735,  -1036.278,    6.120,    228.808),
    vector4(-1637.522,  -1065.947,   13.152,    223.238),
    vector4(-1288.300,   -624.635,   26.813,    182.195),
    vector4(-1249.397,   -594.735,   27.260,    307.731),
    vector4(-1145.583,   -391.092,   36.440,    202.304),
    vector4(-1027.478,    -234.185,  37.839,    189.572),
    vector4(-918.5662,   -200.576,   37.870,     29.831),
    vector4(-837.5192,   -164.246,   37.718,    110.855),
    vector4(-580.6964,    -80.847,   41.915,    334.141),
    vector4(-548.4901,    -44.767,   42.532,     64.592),
}

Real.peds = {
    'a_f_m_bevhills_01',
    'a_f_y_eastsa_03',
    'a_m_m_afriamer_01',
    'a_m_m_golfer_01',
    'a_m_m_mexcntry_01',
    'g_f_y_vagos_01',
    'mp_f_forgery_01',
    's_f_y_clubbar_01',
    's_m_m_autoshop_01',
    's_m_y_dealer_01',
    's_m_y_grip_01',
    'ig_maude'
}

Real.anims = {
    {dict = 'missbigscore2aig_3',                                       anim = 'wait_for_van_c',                flag = 1},
    {dict = 'anim@heists@heist_corona@team_idles@male_a',               anim = 'idle',                          flag = 1},
    {dict = 'anim@heists@humane_labs@finale@strip_club',                anim = 'ped_b_celebrate_loop',          flag = 1},
    {dict = 'anim@amb@nightclub@peds@',                                 anim = 'rcmme_amanda1_stand_loop_cop',  flag = 1},
    {dict = 'amb@world_human_leaning@male@wall@back@foot_up@idle_a',    anim = 'idle_a',                        flag = 1},
    {dict = 'missbigscore2aig_3',                                       anim = 'wait_for_van_c',                flag = 1},
    {dict = 'anim@heists@heist_corona@team_idles@male_a',               anim = 'idle',                          flag = 1},
    {dict = 'anim@heists@humane_labs@finale@strip_club',                anim = 'ped_b_celebrate_loop',          flag = 1},
    {dict = 'anim@amb@nightclub@peds@',                                 anim = 'rcmme_amanda1_stand_loop_cop',  flag = 1},
    {dict = 'amb@world_human_leaning@male@wall@back@foot_up@idle_a',    anim = 'idle_a',                        flag = 1},
    {dict = 'missbigscore2aig_3',                                       anim = 'wait_for_van_c',                flag = 1},
    {dict = 'anim@heists@heist_corona@team_idles@male_a',               anim = 'idle',                          flag = 1}
}
