-- Testbench for arithmetic operations: addition, subtraction, multiplication, division

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity arithmetic_check is
end arithmetic_check;

architecture Behavioral of arithmetic_check is

    -- Component declarations
    component multiplier_16_bit is
        port(
            in1  : in  STD_LOGIC_VECTOR(7 downto 0);
            in2  : in  STD_LOGIC_VECTOR(7 downto 0);
            Clk  : in  STD_LOGIC;
            Rst  : in  STD_LOGIC;
            Outp : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    component division_unit is
        port(
            no1       : in  STD_LOGIC_VECTOR(7 downto 0);
            no2       : in  STD_LOGIC_VECTOR(7 downto 0);
            quotient  : out STD_LOGIC_VECTOR(7 downto 0);
            remainder : out STD_LOGIC_VECTOR(7 downto 0);
            sign_bit  : out STD_LOGIC;
            zero_div  : out STD_LOGIC;
            clk       : in  STD_LOGIC;
            rst       : in  STD_LOGIC
        );
    end component;

    component full_adder_8bit is
        port(
            A    : in  STD_LOGIC_VECTOR(7 downto 0);
            B    : in  STD_LOGIC_VECTOR(7 downto 0);
            Cin  : in  STD_LOGIC;
            Cout : out STD_LOGIC;
            S    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component full_subtracter_8bit is
        port(
            a   : in  STD_LOGIC_VECTOR(7 downto 0);
            b   : in  STD_LOGIC_VECTOR(7 downto 0);
            bin : in  STD_LOGIC;
            bout: out STD_LOGIC;
            d   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals for stimulus and DUT outputs
    signal n1, n2       : std_logic_vector(7 downto 0) := (others => '0');
    signal clk, rst     : std_logic := '0';
    signal add_sum      : std_logic_vector(8 downto 0);
    signal sub_diff     : std_logic_vector(8 downto 0);
    signal mul_out      : std_logic_vector(15 downto 0);
    signal div_quot     : std_logic_vector(7 downto 0);
    signal div_rem      : std_logic_vector(7 downto 0);
    signal div_sign     : std_logic;
    signal div_zero_div : std_logic;

    -- Signals for combinational reference calculations
    signal ref_add      : std_logic_vector(8 downto 0);
    signal ref_sub      : std_logic_vector(8 downto 0);
    signal ref_mul      : std_logic_vector(15 downto 0);

begin

    -- DUT instantiations
    UUT_add: full_adder_8bit
        port map(
            A    => n1,
            B    => n2,
            Cin  => '0',
            Cout => add_sum(8),
            S    => add_sum(7 downto 0)
        );

    UUT_sub: full_subtracter_8bit
        port map(
            a    => n1,
            b    => n2,
            bin  => '0',
            bout => sub_diff(8),
            d    => sub_diff(7 downto 0)
        );

    UUT_mul: multiplier_16_bit
        port map(
            in1  => n1,
            in2  => n2,
            Clk  => clk,
            Rst  => rst,
            Outp => mul_out
        );

    UUT_div: division_unit
        port map(
            no1       => n1,
            no2       => n2,
            quotient  => div_quot,
            remainder => div_rem,
            sign_bit  => div_sign,
            zero_div  => div_zero_div,
            clk       => clk,
            rst       => rst
        );

    -- Reference (combinational) calculations
    ref_add <= std_logic_vector(signed(n1) + signed(n2));
    ref_sub <= std_logic_vector(signed(n1) - signed(n2));
    ref_mul <= std_logic_vector(signed(n1) * signed(n2));


    -- Clock generator
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Reset pulse
    rst_process : process
    begin
        rst <= '1';
        wait for 25 ns;
        rst <= '0';
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Test various cases
        for i in -128 to 127 loop
            for j in -128 to 127 loop
                n1 <= std_logic_vector(to_signed(i, 8));
                n2 <= std_logic_vector(to_signed(j, 8));
                wait for 1500 ns;

                -- Assertions for add
                assert add_sum = ref_add(8 downto 0)
                    report "Addition sum mismatch for " & integer'image(i) & "," & integer'image(j)
                    severity error;

                -- Assertions for sub
                assert sub_diff = ref_sub(8 downto 0)
                    report "Subtraction diff mismatch for " & integer'image(i) & "," & integer'image(j)
                    severity error;

                -- Assertions for mul
                assert mul_out = ref_mul
                    report "Multiplication mismatch for " & integer'image(i) & "," & integer'image(j)
                    severity error;
        
            end loop;
        end loop;
        wait;
    end process;

end Behavioral;
