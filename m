Return-Path: <Prabhat_Singh@Satyam.com>
Received: from chnmail.satyam.com (chnmail.satyam.com [210.18.90.100])
	by ozlabs.org (Postfix) with ESMTP id 59B6F67B1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 16:23:11 +1000 (EST)
Received: from blr.satyam.com (blr.satyam.com [208.220.245.73])
	by che2.satyam.com (8.12.8/8.12.8) with ESMTP id k5K6K3E6015250
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Jun 2006 11:50:03 +0530
Received: from Disclaimerbng.corp.satyam.ad (bng.satyam.com [172.19.57.211])
	by blr.satyam.com (8.12.8/8.12.8) with ESMTP id k5K672qQ017170
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Jun 2006 11:37:02 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C69431.FF58846F"
Subject: Exceptions during PCI initialization at u-boot
Date: Tue, 20 Jun 2006 11:53:06 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED104A5353C@bsdmsg002.corp.satyam.ad>
From: "Prabhat_Singh" <Prabhat_Singh@Satyam.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C69431.FF58846F
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi all

I am getting two exceptions, that you will find in log, at the
pci_hose_read_config_byte memory is crashing that's I found in
System.map. after second exception its boots properly. I have no clue
whats happening. And why I am not able to read Configuration space of
pci.=20

>From where this exception is coming?

Please help me out. What else I can check?

=20

=20

VPN Router Board

=20

=20

Vpn Router U-Boot 1.0.0 (Jun 19 2006 - 11:31:37)

=20

MPC8260 Reset Status: External Soft, External Hard

=20

MPC8260 Clock Configuration

 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq
100-300

 - dfbrg 0, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3

 - vco_out  400000000, scc_clk  100000000, brg_clk  100000000

 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000

=20

CPU:   8272 (HiP7 Rev 14, Mask A.0 1K50M) at 400 MHz

Board: VPN8248

DRAM:  32 MB

total length of code       216456l   34d88value of sdrambase+ramsize
02000000=20

Top of RAM usable for U-Boot at: 02000000

Reserving 211k for U-Boot at: 01fcb000

Reserving 128k for malloc() at: 01faae00

Reserving 76 Bytes for Board Info at: 01faadb4

Reserving 80 Bytes for Global Data at: 01faad64

Stack Pointer at: 01faad48

New Stack Pointer is: 01faad48

value of ret 0=20

Entering reloacte

Now running in RAM - U-Boot at: 01fcb000

POST memory POST memory PASSED

PASSED

FLASH: satyam : manufacturor ID =3D 200020satyam: id1=3D22df22df

satyam: id2=3D0

satyam: id3=3D80008

16 MB

PCI Autoconfig: Memory region: [14000000-1bffffff]

PCI Autoconfig: I/O region: [1c000000-1dffffff]

Bus Fault @ 0x01fd2df8, fixup 0x00000000

Machine check in kernel mode.

Caused by (from msr): regs 01faab60 Unknown values in msr

NIP: 01FD2DF8 XER: 00000000 LR: 01FD2DF0 REGS: 01faab60 TRAP: 0200 DAR:
01FE4DB8

MSR: 00083002 EE: 0 PR: 0 FP: 1 ME: 1 IR/DR: 00

=20

GPR00: 01FD3A24 01FAAC50 FFFFFFFF 00000000 8000080C 00000002 01FAAC5E
01C5D1FB=20

GPR08: 01FD0084 F0010904 00000000 00000000 00000020 FFFFFFFF 01FF8000
020CB000=20

GPR16: FFFFFFFF FFFFFFFF FFFFFEFF FFFFFFFF 00000000 00000000 FFFFFFFF
F0010D20=20

GPR24: 00000000 00000000 01FFE39C 00000100 01FFE39C 01FAAD64 01FF8400
00000800=20

Call backtrace:=20

01FD3A24 01FD3BF0 01FE8B84 01FE3E04 01FD3C64 01FCFE30 01FCE48C=20

machine check

VPN Router Board

=20

=20

Vpn Router U-Boot 1.0.0 (Jun 19 2006 - 11:31:37)

=20

MPC8260 Reset Status:

=20

MPC8260 Clock Configuration

 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq
100-300

 - dfbrg 0, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3

 - vco_out  400000000, scc_clk  100000000, brg_clk  100000000

 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000

=20

CPU:   8272 (HiP7 Rev 14, Mask A.0 1K50M) at 400 MHz

Board: VPN8248

DRAM:  32 MB

total length of code       216456l   34d88value of sdrambase+ramsize
02000000=20

Top of RAM usable for U-Boot at: 02000000

Reserving 211k for U-Boot at: 01fcb000

Reserving 128k for malloc() at: 01faae00

Reserving 76 Bytes for Board Info at: 01faadb4

Reserving 80 Bytes for Global Data at: 01faad64

Stack Pointer at: 01faad48

New Stack Pointer is: 01faad48

Entering reloacte

Now running in RAM - U-Boot at: 01fcb000

FLASH: satyam : manufacturor ID =3D 200020satyam: id1=3D22df22df

PCI Autoconfig: Memory region: [14000000-1bffffff]

PCI Autoconfig: I/O region: [1c000000-1dffffff]

vendor=3D168c

PCI Scan: Found Bus 0, Device 15, Function 0

PCI Autoconfig: BAR 0, Mem, size=3D0x10000, address=3D0x14000000

PCI Autoconfig: BAR 1, I/O, size=3D0xffffb000, No room in resource

PCI:     00  0f  168c  0013  0200  00

value of item =3D1

In:    serial

Out:   serial

Err:   serial

Chip Name  =3D 175a

Chip Name  =3D 175c

phy ID(0x02430d80) =3D 02430d80

Level One/ICPLUS PHY Identied IC175C Revision 0

Phy operating at 100 MBit/s in full-duplex mode

Phy operating at 100 MBit/s in full-duplex mode

U-Boot relocated to 01fcb000

Net:   value of fec FCC2 ETHERNET=20

FCC2 ETHERNET

Hit any key to stop autoboot:  5 =08=08=08 4 =08=08=08 3 =08=08=08 0=20

satyam=3D> =20

=20

Regards'

Prabhat Singh

=20

=20



DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.

------_=_NextPart_001_01C69431.FF58846F
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Hi =
all<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>I am getting </span></font><font =
color=3Dred><span
style=3D'color:red'>two </span></font><font color=3Dblue><span =
style=3D'color:blue'>exceptions,
that you will find in log, at the pci_hose_read_config_byte memory is =
crashing
that&#8217;s I found in System.map. after second exception its boots =
properly.
I have no clue whats happening. And why I am not able to read =
Configuration
space of pci. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>From where this exception is =
coming?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Please help me out. What else I =
can check?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>VPN Router =
Board<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Vpn Router U-Boot 1.0.0 (Jun 19 =
2006 -
11:31:37)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>MPC8260 Reset Status: External =
Soft,
External Hard<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>MPC8260 Clock =
Configuration<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>&nbsp;- Bus-to-Core Mult 4x, VCO =
Div 2, 60x
Bus Freq&nbsp; 25-75 , Core Freq 100-300<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>&nbsp;- dfbrg 0, corecnf 0x1a, =
busdf 3,
cpmdf 1, plldf 0, pllmf 3<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>&nbsp;- vco_out&nbsp; 400000000,
scc_clk&nbsp; 100000000, brg_clk&nbsp; =
100000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>&nbsp;- cpu_clk&nbsp; 400000000,
cpm_clk&nbsp; 200000000, bus_clk&nbsp; =
100000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>CPU:&nbsp;&nbsp; 8272 (HiP7 Rev =
14, Mask
A.0 1K50M) at 400 MHz<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Board: =
VPN8248<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>DRAM:&nbsp; 32 =
MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>total length of code
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 216456l&nbsp;&nbsp; 34d88value of
sdrambase+ramsize 02000000 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Top of RAM usable for U-Boot at: =
02000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Reserving 211k for U-Boot at: =
01fcb000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Reserving 128k for malloc() at: =
01faae00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Reserving 76 Bytes for Board Info =
at:
01faadb4<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Reserving 80 Bytes for Global Data =
at:
01faad64<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Stack Pointer at: =
01faad48<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>New Stack Pointer is: =
01faad48<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>value of ret 0 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Entering =
reloacte<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Now running in RAM - U-Boot at: =
01fcb000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>POST memory POST memory =
PASSED<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>PASSED<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>FLASH: satyam : manufacturor ID =
=3D
200020satyam: id1=3D22df22df<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>satyam: =
id2=3D0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>satyam: =
id3=3D80008<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>16 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>PCI Autoconfig: Memory region:
[14000000-1bffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>PCI Autoconfig: I/O region:
[1c000000-1dffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Bus Fault @ 0x01fd2df8, fixup =
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Machine check in kernel =
mode.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Caused by (from msr): regs =
01faab60 Unknown
values in msr<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>NIP: 01FD2DF8 XER: 00000000 LR: =
01FD2DF0
REGS: 01faab60 TRAP: 0200 DAR: 01FE4DB8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>MSR: 00083002 EE: 0 PR: 0 FP: 1 =
ME: 1
IR/DR: 00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>GPR00: 01FD3A24 01FAAC50 FFFFFFFF =
00000000
8000080C 00000002 01FAAC5E 01C5D1FB <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>GPR08: 01FD0084 F0010904 00000000 =
00000000
00000020 FFFFFFFF 01FF8000 020CB000 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>GPR16: FFFFFFFF FFFFFFFF FFFFFEFF =
FFFFFFFF
00000000 00000000 FFFFFFFF F0010D20 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>GPR24: 00000000 00000000 01FFE39C =
00000100
01FFE39C 01FAAD64 01FF8400 00000800 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Call backtrace: =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>01FD3A24 01FD3BF0 01FE8B84 =
01FE3E04
01FD3C64 01FCFE30 01FCE48C <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>machine =
check<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>VPN Router =
Board<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Vpn Router U-Boot 1.0.0 (Jun 19 =
2006 -
11:31:37)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>MPC8260 Reset =
Status:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>MPC8260 Clock =
Configuration<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>&nbsp;- Bus-to-Core Mult 4x, VCO =
Div 2, 60x
Bus Freq&nbsp; 25-75 , Core Freq 100-300<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>&nbsp;- dfbrg 0, corecnf 0x1a, =
busdf 3,
cpmdf 1, plldf 0, pllmf 3<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>&nbsp;- vco_out&nbsp; 400000000,
scc_clk&nbsp; 100000000, brg_clk&nbsp; =
100000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>&nbsp;- cpu_clk&nbsp; 400000000,
cpm_clk&nbsp; 200000000, bus_clk&nbsp; =
100000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>CPU:&nbsp;&nbsp; 8272 (HiP7 Rev =
14, Mask
A.0 1K50M) at 400 MHz<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Board: =
VPN8248<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>DRAM:&nbsp; 32 =
MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>total length of code
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 216456l&nbsp;&nbsp; 34d88value of
sdrambase+ramsize 02000000 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Top of RAM usable for U-Boot at: =
02000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Reserving 211k for U-Boot at: =
01fcb000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Reserving 128k for malloc() at: =
01faae00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Reserving 76 Bytes for Board Info =
at:
01faadb4<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Reserving 80 Bytes for Global Data =
at:
01faad64<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Stack Pointer at: =
01faad48<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>New Stack Pointer is: =
01faad48<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Entering =
reloacte<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Now running in RAM - U-Boot at: =
01fcb000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>FLASH: satyam : manufacturor ID =
=3D
200020satyam: id1=3D22df22df<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>PCI Autoconfig: Memory region:
[14000000-1bffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>PCI Autoconfig: I/O region:
[1c000000-1dffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>vendor=3D168c<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>PCI Scan: Found Bus 0, Device 15, =
Function
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>PCI Autoconfig: BAR 0, Mem, =
size=3D0x10000,
address=3D0x14000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>PCI Autoconfig: BAR 1, I/O,
size=3D0xffffb000, No room in resource<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>PCI:&nbsp;&nbsp;&nbsp;&nbsp; =
00&nbsp;
0f&nbsp; 168c&nbsp; 0013&nbsp; 0200&nbsp; =
00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>value of item =
=3D1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>In:&nbsp;&nbsp;&nbsp; =
serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Out:&nbsp;&nbsp; =
serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Err:&nbsp;&nbsp; =
serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Chip Name&nbsp; =3D =
175a<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Chip Name&nbsp; =3D =
175c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>phy ID(0x02430d80) =3D =
02430d80<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Level One/ICPLUS PHY Identied =
IC175C
Revision 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Phy operating at 100 MBit/s in =
full-duplex
mode<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Phy operating at 100 MBit/s in =
full-duplex
mode<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>U-Boot relocated to =
01fcb000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Net:&nbsp;&nbsp; value of fec FCC2 =
ETHERNET
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>FCC2 =
ETHERNET<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Hit any key to stop =
autoboot:&nbsp; 5 =08=08=08
4 =08=08=08 3 =08=08=08 0 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3 =
color=3Dblue
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;color:blue'>satyam=3D&gt;
&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Regards&#8217;<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblue face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:blue'>Prabhat =
Singh<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

<p></p><p>DISCLAIMER:<br>This email (including any attachments) is =
intended for the sole use of the intended recipient/s and may contain =
material that is CONFIDENTIAL AND PRIVATE COMPANY INFORMATION. Any =
review or reliance by others or copying or distribution or forwarding of =
any or all of the contents in this message is STRICTLY PROHIBITED. If =
you are not the intended recipient, please contact the sender by email =
and delete all copies; your cooperation in this regard is =
appreciated..</body>

</html>

------_=_NextPart_001_01C69431.FF58846F--
