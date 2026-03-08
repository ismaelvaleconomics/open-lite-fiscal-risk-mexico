// =====================================================
// OPEN_Fiscal(lineal, SS=0) — versión con Taylor sobre Δe
// =====================================================

var 
    gap y pi i
    g tau pb
    d
    e de
    i_star rp
;

varexo
    ey epi ei
    eg etau ed
    ee estar erp
;

// ------------------- Parámetros -------------------
parameters
    beta kappa_pi chi_de
    rho_gap a_yg a_yt
    agg atta
    gamma_g gamma_t
    k_d
    phi_pi phi_y phi_e
    rho_istar
    rho_rp k_rp
;

// ------------------- Calibración base (editables) -------------------
beta     = 0.99;
kappa_pi = 0.05;
chi_de   = 0.02;

rho_gap  = 0.40;
a_yg     = 0.00;
a_yt     = 0.00;

agg      = 0.20;
atta     = 0.30;
gamma_g  = 0.15;
gamma_t  = 0.20;
k_d      = 0.02;

phi_pi   = 1.50;
phi_y    = 0.50;
phi_e    = 0.30;

rho_istar= 0.85;
rho_rp   = 0.80;
k_rp     = 0.005;

// ------------------- Modelo (lineal en desvíos) -------------------
model(linear);

  // (1) IS en brecha
  gap = rho_gap*gap(-1) + a_yg*g(-1) + a_yt*tau(-1) + ey;

  // (2) PIB ≈ brecha
  y = gap;

  // (3) Phillips NK (FWD) con traspaso cambiario
  pi = beta*pi(+1) + kappa_pi*gap + chi_de*de + epi;

  // (4) Regla de Taylor abierta: reacciona a inflación, brecha y Δe
  i = phi_pi*pi + phi_y*gap + phi_e*de + ei;

  // (5) UIP (e es variable de salto)
  e(+1) = e + i - i_star + rp + ee;

  // (6) Variación del tipo de cambio
  de = e - e(-1);

  // (7) Tasa externa (AR)
  i_star = rho_istar*i_star(-1) + estar;

  // (8) Prima de riesgo (AR + canal deuda)
  rp = rho_rp*rp(-1) + k_rp*d(-1) + erp;

  // (9) Gasto (desvío) — inercia + estabilizador
  g = agg*g(-1) + gamma_g*gap + eg;

  // (10) Ingresos (desvío) — inercia + estabilizador + regla sobre deuda
  tau = atta*tau(-1) + gamma_t*gap + k_d*d(-1) + etau;

  // (11) Primario (desvío)
  pb = tau - g;

  // (12) Deuda (desvío) — acumulación linealizada
  d = d(-1) - pb + ed;

end;

// ------------------- Estado estacionario (desvíos = 0) -------------------
steady_state_model;
  gap = 0; y = 0; pi = 0; i = 0;
  g = 0; tau = 0; pb = 0;
  d = 0;
  e = 0; de = 0;
  i_star = 0; rp = 0;
end;

resid; steady; check;

// ========= Experimentos de consolidación (elige uno) ==========

// (A) Consolidación por recorte de gasto (shock negativo a eg)
//shocks;
//  var ey    = (0.005)^2;
//  var epi   = (0.002)^2;
//  var ei    = (0.002)^2;
//  var eg    = (0.003)^2;
//  var etau  = (0.003)^2;
//  var ed    = (0.002)^2;
//  var ee    = (0.005)^2;
//  var estar = (0.002)^2;
//  var erp   = (0.003)^2;
//
//  // one-off consolidación (t=1): -0.5% del gasto (desvío)
//  var eg; stderr 0.003; // var base para IRFs
//  // Para un impulso dirigido, usa 'shock' puntual:
//  // Nota: con stoch_simul, el impulso estándar es 1*stderr.
//end;

// (B) Consolidación por aumento de ingresos (shock positivo a etau)
shocks;
  var ey    = (0.005)^2;
  var epi   = (0.002)^2;
  var ei    = (0.002)^2;

  var eg    = (0.003)^2;
  var etau  = (0.003)^2;
  var ed    = (0.002)^2;

  var ee    = (0.005)^2;
  var estar = (0.002)^2;
  var erp   = (0.003)^2;

  // one-off consolidación (t=1): +0.5% en ingresos (desvío)
  // Igual que arriba: el impulso estándar es 1*stderr de etau.
end;

// ------------------- IRFs -------------------
stoch_simul(order=1, irf=24)
  y gap pi i e de g tau pb d rp i_star;