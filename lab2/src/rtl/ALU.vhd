library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALU is
  generic (
    N : integer := 8
  );
  port (
    A_IN    : in  std_logic_vector(N-1 downto 0);
    B_IN    : in  std_logic_vector(N-1 downto 0);
    Cin  : in  std_logic                   ;
    S    : in  std_logic_vector(3 downto 0);
    F    : out std_logic_vector(N-1 downto 0);
    Cout : out std_logic
  );
end entity ALU;

architecture ArchALU of ALU is

-- Component Declarations
  component A is
    generic (
      N : integer := 8
    );
    port (
      A     : in  std_logic_vector (N-1 downto 0) ;
      B     : in  std_logic_vector (N-1 downto 0) ;
      Cin   : in  std_logic                     ;
      S     : in  std_logic_vector (3 downto 0) ;
      F     : out std_logic_vector (N-1 downto 0) ;
      Cout  : out std_logic                     
    );
  end component;

  component B is
    generic (
      N : integer := 8
    );
    port (
      A     : in  std_logic_vector (N-1 downto 0) ;
      B     : in  std_logic_vector (N-1 downto 0) ;
      Cin   : in  std_logic                     ;
      S     : in  std_logic_vector (3 downto 0) ;
      F     : out std_logic_vector (N-1 downto 0) ;
      Cout  : out std_logic
    ) ;
  end component;

  component C is
    generic (
      N : integer := 8
    );
    port (
      A       : in  std_logic_vector (N-1 downto 0) ;
      B       : in  std_logic_vector (N-1 downto 0) ;
      Cin     : in  std_logic                     ;
      S       : in  std_logic_vector (3 downto 0) ;
      F       : out std_logic_vector (N-1 downto 0) ;
      Cout    : out std_logic
    ) ;
  end component;

  component D is
    generic (
      N : integer := 8
    );
    port (
      A     : in  std_logic_vector (N-1 downto 0) ;
      B     : in  std_logic_vector (N-1 downto 0) ;
      Cin   : in  std_logic                     ;
      S     : in  std_logic_vector (N-1 downto 0) ;
      F     : out std_logic_vector (N-1 downto 0) ;
      Cout  : out std_logic
    ) ;
  end component;

  -- Signals
  signal F_A : std_logic_vector(N-1 downto 0);
  signal Cout_A : std_logic;
  signal F_B : std_logic_vector(N-1 downto 0);
  signal Cout_B : std_logic;
  signal F_C : std_logic_vector(N-1 downto 0);
  signal Cout_C : std_logic;
  signal F_D : std_logic_vector(N-1 downto 0);
  signal Cout_D : std_logic;
 

begin
 
  A_inst: A generic map (N => N) port map(A_IN, B_IN, Cin, S, F_A, Cout_A);
  B_inst: B generic map (N => N) port map(A_IN, B_IN, Cin, S, F_B, Cout_B);
  C_inst: C generic map (N => N) port map(A_IN, B_IN, Cin, S, F_C, Cout_C);
  D_inst: D generic map (N => N) port map(A_IN, B_IN, Cin, S, F_D, Cout_D);

  with S(3 downto 2) select
  F <= F_A when "00",
       F_B when "01",
       F_C when "10",
       F_D when "11",
       (others => '0') when others;

  with S(3 downto 2) select
  Cout <= Cout_A when "00",
          Cout_B when "01",
          Cout_C when "10",
          Cout_D when "11",
          '0' when others;
  
end architecture ArchALU;
