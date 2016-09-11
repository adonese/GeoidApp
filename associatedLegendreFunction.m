function Pnm = associatedLegendreFunction(nmax, m, colatd)
%%associatedLegendreFunction takes in nmax, m, colatd as inputs. Returns the Pnm.
% A part of geoid_height function.


% Dr. Ahmed Abdalla, Mohamed Jaafar, and Mohamed Yousif.

colatd = 90 - colatd;

% Remove the 90 when done.

Ni = length(colatd);
Nj = nmax - m + 1;
Pnm = zeros(Ni,Nj);

colat = colatd(:) / rad;
u = sin(colat);
t = cos(colat);

% sectoral seed, Eq 13

% Pnm(0,0) = 0;
if m == 0
   Pnm(:, 1) = 1;
elseif m == 1
   Pnm(:, 1) = sqrt(3)*u;
elseif m > 1
   i = 2 * (2 : m);
   i1 = sqrt((i + ones(size(i))) ./ i);
   Pnm(:, 1) = u .^ m * sqrt(3) * prod(i1);
end

if m == nmax
   return
end

% recursion for non-sectoral Pnm: nmax == m + 1
n = m + 1;
anm = sqrt((2*n - 1)*(2*n + 1)/((n - m)*(n + m)));
Pnm(:, 2) = anm * t .* Pnm(:, 1);

if m + 1 == nmax
   return
end

j = 3;
for n = m + 2:nmax
   anm = sqrt((2 * n - 1)*(2 * n + 1)/((n - m)*(n + m)));
   bnm = sqrt((2 * n + 1)*(n + m - 1)*(n - m - 1)/((n - m)*(n + m)*(2 * n - 3)));
   Pnm(:, j) = anm * t .* Pnm(:, j - 1) - bnm*Pnm(:, j - 2);
   j = j + 1;
end
end

