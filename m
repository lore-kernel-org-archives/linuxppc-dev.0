Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 23 Apr 2004 16:37:00 +0500 (GMT+0500)
From: Ashish R Dhawane <ashish@cdotb.ernet.in>
To: linuxppc-embedded@lists.linuxppc.org
Subject: U-Boot Problem (MPC8260) 
In-Reply-To: <000f01c42562$d3713150$a81e1aac@liuming>
Message-ID: <Pine.OSF.4.21.0404211715180.5736-100000@ws9.cdotb.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am newbie to the Linux Porting. I am having a mpc8260 board(custom
made). I am trying to configure the cogent mpc8260 board. For a testing
purpose, I am running U-Boot in the SDRAM area, but not from the
flash. I am getting the following error messages. Any help will
appreciated.

OutPut which is captured on minicom is as follows:
--------------------------------------------------

U-Boot Version 2.0.0p

U-Boot V 2.0.0lw

MPC8260 Reset Status:

MPC8260 Clock Configuration
 - Bus-to-Core Mult 3x, VCO Div 2, 60x Bus Freq  33-100, Core Freq 100-300
 - dfbrg 0, corecnf 0x08, busdf 4, cpmdf 1, plldf 1, pllmf 4
 - vco_out  333333330, scc_clk   83333332, brg_clk   83333332
 - cpu_clk  199999998, cpm_clk  166666665, bus_clk   66666666

CPU:   MPC8260 (Rev 14, Mask B.1 4K25A) at 199.999 MHz
Board: Cogent CMA111 motherboard with a CMA282 CPU Module
DIPSW: |off|off|off|off|off|off|off|off|
DRAM:  32 MB
Top of RAM usable for U-Boot at: 02000000
Reserving 128k for U-Boot at: 01fdf000
Reserving 144k for malloc() at: 01fbb000
Reserving 76 Bytes for Board Info at: 01fbafb4
Reserving 68 Bytes for Global Data at: 01fbaf70
Stack Pointer at: 01fbaf58
New Stack Pointer is: 01fbaf58
Now running in RAM - U-Boot at: 01fdf000
FLASH: *** failed ***
### ERROR ### Please RESET the board ###

regards,
-Ashish

###########################################################################
Ashish R Dhawane
Senior Research Engineer
W-CDMA Group (3G RAN)

Contacts:
---------
Tel(O)	   :+91-80-2282168 (Direct Line)
Tel(O/Lab) :+91-80-2263399 X 329
Fax(O)	   :+91-80-2282168
Mobile	   :98455 36814
E-Mail(s)  :ashishdhawane@yahoo.com, ashish@cyberspace.org

Surface Address (O):			Surface Address (R):
--------------------			--------------------
Centre for Development of Telematics,	#50, Ground Floor, 12th Cross,
71/1, Sneha Complex, 			Ayyappa Block, Manorayan Palya,
Millers Road,				Sultan Palya Main Road,
Bangalore-560052,			RT Nagar Post,Bangalore-560032,
Karnataka, India.			Karnataka, India.
###########################################################################


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
