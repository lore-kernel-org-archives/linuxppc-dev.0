Return-Path: <anildahiya80@gmail.com>
Received: from mail-px0-f181.google.com (mail-px0-f181.google.com
	[209.85.216.181])
	by bilbo.ozlabs.org (Postfix) with ESMTP id DD3A4B707D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 15:15:27 +1000 (EST)
Received: by pxi11 with SMTP id 11so2948772pxi.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 22:15:25 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 15 Jul 2009 10:45:25 +0530
Message-ID: <73afa9bf0907142215p1032f6adw7c7d7c7ab2eb0e01@mail.gmail.com>
Subject: riscwatch shows up core status UNKNOWN for 970mp ppc processor
From: anil kumar <anildahiya80@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636e0aa3387bf9e046eb7a43d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636e0aa3387bf9e046eb7a43d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello
I am newbie to RISCWatch and debugging using JTAG interface .I want to debug
Linux Kernel on target board
using jtag interface provided on board.

To  debug 970MP dual core ppc processor on traget board, I installed
RISCWatch software on my window host.

My Setup:
----------
   Host <--(over ethernet)--> RISCWatch 13H6423 <--(jtag interface)--> 970MP
Processor

I am able to detect two core on target 970MP processor but it shows both
cores as `UNKNOWN` . I have no idea,
why riscwatch shows up status of both cores as UNKNOWN?

I would like to mention:
-------------------------
1) After attaching JTAG cable & switching on riscwatch box, powered cycle
was done on the target board
   and restart RISCWatch. But still core status is shown `UNKNOWN`
2) For PVR value 0x00440101, I used `REV = 1' in rwppc.env file. Correct us
if I am wrong.
3) I am able to ping RISCWatch 13H6423 from host system.
4) When I reset target board, target status changes from "UNKNOWN to HALTED"
and "HALTED to UNKNOWN"

I noticed that PVR register value is 0x00440101. I am not sure if this
confirms that revision of the processor(970mp) is 1.


Please find the rwppc.env file (C:\Program Files\RISCWatch\rwppc.env) that I
configured:
----------------------------------------------------------------------------------------
PROC = 970MP
REV =  1
TARGET_TYPE = jtag_eth
TARGET_NAME = 192.168.10.5
RWPPC_DIR = .
SEARCH_PATH = .
LOG_FILE_DIR = .
SAVE_LAYOUT = no
PRD_FILE = rwppc.prd



Please find board information:
------------------------------

KAT2000 970MP (1.0)=> boardinfo
board config data version: 1.0
processor name           : 970MP
processor PVR value      : 0x00440101
timer clock frequency    : 112500000
total SDRAM memory       : 4096MB
SDRAM frequency          : 533333333
system clk frequency (Hz): 225000000
CPU frequency            : 1800000000
CPU frequency ind. est.  : 1800001200
CPU to EI speed ratio    : 2:1
frequency scaling divider: 1
serial clk frequency     : 1843200
HID0 value               : 0011008180000000
HID1 value               : fd3c200000000000
HID4 value               : 0000001000000000
HID5 value               : 0000000000000080
SDR1 value               : 0000000000d00002
PIR  value               : 00000000
Ethernet hardware addr 0 : FFFFFFFFFFFF


RISCWatch log:
--------------

12:37:18 - RISCWatch program start
12:37:18 - RISCWatch  v7.1 for Windows XP
12:37:18 - Current directory: C:\Program Files\RISCWatch
12:37:18 - Environment file: RWPPC.ENV
12:37:18 - RWPPC_DIR = .
12:37:18 - TARGET_TYPE = JTAG_Ethernet
12:37:18 - TARGET_NAME = 192.168.10.5
12:37:18 - Requested Processor 970MPRev1:CORE1
12:37:18 - Requested Processor 970MPRev1:CORE2
12:37:18 - Unable to get port number for jtag_eth service, using 6470
default 12:37:30 - Configuring probe 12:37:30 - cf default; jtagch a32,a32
12:37:31 - HPE8130A Series Emulation System
12:37:31 -     Version:   A.01.20 04Apr02 Unreleased
12:37:31 -     Location:  Generics
12:37:31 - HPEGPUL  PowerPC 970 JTAG Emulator
12:37:31 -     Version:   A.00.I0 22Jul08 13:48 Proto
12:37:31 -  WARNING : Could not read processor status, slowing JTAG clock
and retrying
12:37:31 -  ERROR : bad status received, see README for possible causes
12:37:36 - Starting MPS mode
12:43:18 -  STATUS : CORE1 status changed from UNKNOWN to HALTED
12:43:18 -  STATUS : CORE2 status changed from UNKNOWN to HALTED
      Note---> Status become HALTED because I reset target board

12:43:19 -  ERROR : CORE1 status changed from HALTED to UNKNOWN
12:43:19 -  ERROR : CORE2 status changed from HALTED to UNKNOWN


Regards,
Anil

--001636e0aa3387bf9e046eb7a43d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello <br>I am newbie to RISCWatch and debugging using JTAG interface .I wa=
nt to debug Linux Kernel on target board <br>using jtag interface provided =
on board.<br><br>To=A0 debug 970MP dual core ppc processor on traget board,=
 I installed RISCWatch software on my window host. <br>
<br>My Setup:<br>
----------<br>
=A0=A0 Host &lt;--(over ethernet)--&gt; RISCWatch 13H6423 &lt;--(jtag inter=
face)--&gt; 970MP Processor=A0 <br>
<br>I am able to detect two core on target 970MP processor but it shows bot=
h cores as `UNKNOWN` . I have no idea, <br>why riscwatch shows up status of=
 both cores as UNKNOWN?<br><br>I would like to mention:<br>----------------=
---------<br>
1) After attaching JTAG cable &amp; switching on riscwatch box, powered cyc=
le was done on the target board <br>=A0=A0 and restart RISCWatch. But still=
 core status is shown `UNKNOWN`<br>2) For PVR value 0x00440101, I used `REV=
 =3D 1&#39; in rwppc.env file. Correct us if I am wrong.<br>
3) I am able to ping RISCWatch 13H6423 from host system.<br>4) When I reset=
 target board, target status changes from &quot;UNKNOWN to HALTED&quot; and=
 &quot;HALTED to UNKNOWN&quot;<br><br>I noticed that PVR register value is =
0x00440101. I am not sure if this confirms that revision of the processor(9=
70mp) is 1.<br>

<br><br>Please find the rwppc.env file (C:\Program Files\RISCWatch\rwppc.en=
v) that I configured:<br>
---------------------------------------------------------------------------=
-------------<br>
PROC =3D 970MP<br>
REV =3D=A0 1<br>
TARGET_TYPE =3D jtag_eth<br>
TARGET_NAME =3D 192.168.10.5<br>
RWPPC_DIR =3D .<br>
SEARCH_PATH =3D .<br>
LOG_FILE_DIR =3D .<br>
SAVE_LAYOUT =3D no<br>
PRD_FILE =3D rwppc.prd<br>
=A0<br>
<br><br>Please find board information:<br>------------------------------<br=
><br>KAT2000 970MP (1.0)=3D&gt; boardinfo<br>board config data version: 1.0=
<br>processor name=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 970MP<br>processor PVR v=
alue=A0=A0=A0=A0=A0 : 0x00440101<br>
timer clock frequency=A0=A0=A0 : 112500000<br>total SDRAM memory=A0=A0=A0=
=A0=A0=A0 : 4096MB<br>SDRAM frequency=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 53333333=
3<br>system clk frequency (Hz): 225000000<br>CPU frequency=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 : 1800000000<br>CPU frequency ind. est.=A0 : 1800001200<=
br>
CPU to EI speed ratio=A0=A0=A0 : 2:1<br>frequency scaling divider: 1<br>ser=
ial clk frequency=A0=A0=A0=A0 : 1843200<br>HID0 value=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 : 0011008180000000<br>HID1 value=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 : fd3c200000000000<br>HID4 value=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 : 0000001000000000<br>
HID5 value=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 0000000000000080<br>=
SDR1 value=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 0000000000d00002<br>=
PIR=A0 value=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 00000000<br>Ethern=
et hardware addr 0 : FFFFFFFFFFFF<br>=A0<br>=A0<br>RISCWatch log:<br>------=
--------<br>
<br>12:37:18 - RISCWatch program start<br>12:37:18 - RISCWatch=A0 v7.1 for =
Windows XP<br>12:37:18 - Current directory: C:\Program Files\RISCWatch<br>1=
2:37:18 - Environment file: RWPPC.ENV<br>12:37:18 - RWPPC_DIR =3D .<br>12:3=
7:18 - TARGET_TYPE =3D JTAG_Ethernet<br>
12:37:18 - TARGET_NAME =3D 192.168.10.5<br>12:37:18 - Requested Processor 9=
70MPRev1:CORE1<br>12:37:18 - Requested Processor 970MPRev1:CORE2<br>12:37:1=
8 - Unable to get port number for jtag_eth service, using 6470 default 12:3=
7:30 - Configuring probe 12:37:30 - cf default; jtagch a32,a32<br>
12:37:31 - HPE8130A Series Emulation System<br>12:37:31 -=A0=A0=A0=A0 Versi=
on:=A0=A0 A.01.20 04Apr02 Unreleased=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>12:37:3=
1 -=A0=A0=A0=A0 Location:=A0 Generics<br>12:37:31 - HPEGPUL=A0 PowerPC 970 =
JTAG Emulator=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>12:37:31 -=
=A0=A0=A0=A0 Version:=A0=A0 A.00.I0 22Jul08 13:48 Proto=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 <br>
12:37:31 -=A0 WARNING : Could not read processor status, slowing JTAG clock=
 and retrying<br>12:37:31 -=A0 ERROR : bad status received, see README for =
possible causes<br>12:37:36 - Starting MPS mode<br>12:43:18 -=A0 STATUS : C=
ORE1 status changed from UNKNOWN to HALTED<br>
12:43:18 -=A0 STATUS : CORE2 status changed from UNKNOWN to HALTED<br>=A0=
=A0=A0=A0=A0 Note---&gt; Status become HALTED because I reset target board<=
br>=A0=A0=A0=A0=A0=A0=A0=A0 <br>12:43:19 -=A0 ERROR : CORE1 status changed =
from HALTED to UNKNOWN<br>12:43:19 -=A0 ERROR : CORE2 status changed from H=
ALTED to UNKNOWN<br>
<br><br>Regards,<br>Anil<br><br><br>

--001636e0aa3387bf9e046eb7a43d--
