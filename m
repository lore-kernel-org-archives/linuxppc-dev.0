Return-Path: <SRane@alphion.com>
Received: from mail.alphion.com (unknown [66.147.184.82])
	by ozlabs.org (Postfix) with ESMTP id E9D6EDDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jun 2007 22:35:58 +1000 (EST)
Subject: 'mmap' memory access causes Bus Error
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7B3FF.0BB2ECBA"
Date: Thu, 21 Jun 2007 08:23:59 -0400
Message-ID: <8584FDC94AFF7640B17B8A89B23B19B34F666C@sbsserver.AlphionCorp.local>
From: "Sachin Rane" <SRane@alphion.com>
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

------_=_NextPart_001_01C7B3FF.0BB2ECBA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I got an 'Bus Error' when tried to access 'mmap' PCI memory on PPC440GX =
machine.
I  verified this behavior with D-Link Ethernet Network card and Broadcom =
device.
I have appeneded the log for reference.

But the same program works fine  on i386 machine i.e. accessing 'mmap' =
PCI memory works fine.
=20
Any clue or solution for this problem on PPC440GX machine?
=20
=20
Regards,
Sachin Rane

8<--------------------------------------------------------------------
Machine check in kernel mode.
Data Write PLB Error
PLB0: BEAR=3D0x00000000fffe0000 ACR=3D  0x9b000000 BESR=3D 0x00800000
POB0: BEAR=3D0x00000005dfff74df BESR0=3D0x00000000 BESR1=3D0x00000000
OPB0: BEAR=3D0x0000000f7fffffef BSTAT=3D0x00000000
Oops: machine check, sig: 7 [#3]
NIP: C0002420 LR: C00022C4 CTR: 00000000
REGS: c020ff50 TRAP: 0202   Not tainted  (2.6.16.1)
MSR: 00029000 <EE,ME>  CR: 22000484  XER: 00000000
TASK =3D c7d63450[40] 'cdksim' THREAD: c79dc000
GPR00: 00000000 C79DDF40 C7D63450 00004000 00000001 00000000 C785B940 =
7FA18498
GPR08: 00000000 00000004 00029002 00000000 22000482 100AFAA0 07FF5000 =
007FFF3C
GPR16: 00000000 00000001 00000000 7FA18480 00000000 10195BA0 7FA18498 =
10195BB8
GPR24: 00000000 00000001 30021800 7FD75C50 00000000 00000000 10047234 =
7FD745E0
NIP [C0002420] do_user_signal+0x8/0xc4
LR [C00022C4] ret_from_mcheck_exc+0x0/0xe0
Call Trace:
[C79DDF40] [C00022C4] ret_from_mcheck_exc+0x0/0xe0 (unreliable)
Instruction dump:
48182ccd 3d400002 614a1002 7d400124 54290024 81290024 71200008 40a2ffdc
71200004 4182fc74 614a8000 7d400124 <806100b0> 70600001 41820058 =
91a10044
8<--------------------------------------------------------------------
=20

------_=_NextPart_001_01C7B3FF.0BB2ECBA
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.6000.16481" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>Hi,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>I got an 'Bus Error' =
when tried to access 'mmap' PCI memory on PPC440GX machine.<BR>I&nbsp; =
verified this behavior with D-Link Ethernet Network card and Broadcom =
device.<BR>I have appeneded the log for reference.<BR></FONT></DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>But the same program =
works fine&nbsp; on i386 machine i.e. accessing 'mmap' PCI memory works =
fine.</FONT></DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>Any clue or solution =
for this problem on PPC440GX machine?</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>Regards,<BR>Sachin =
Rane</FONT></DIV><FONT face=3DArial color=3D#000000 size=3D2>=0A=
<DIV><BR>8&lt;-----------------------------------------------------------=
---------<BR>Machine check in kernel mode.<BR>Data Write PLB =
Error<BR>PLB0: BEAR=3D0x00000000fffe0000 ACR=3D&nbsp; 0x9b000000 BESR=3D =
0x00800000<BR>POB0: BEAR=3D0x00000005dfff74df BESR0=3D0x00000000 =
BESR1=3D0x00000000<BR>OPB0: BEAR=3D0x0000000f7fffffef =
BSTAT=3D0x00000000<BR>Oops: machine check, sig: 7 [#3]<BR>NIP: C0002420 =
LR: C00022C4 CTR: 00000000<BR>REGS: c020ff50 TRAP: 0202&nbsp;&nbsp; Not =
tainted&nbsp; (2.6.16.1)<BR>MSR: 00029000 &lt;EE,ME&gt;&nbsp; CR: =
22000484&nbsp; XER: 00000000<BR>TASK =3D c7d63450[40] 'cdksim' THREAD: =
c79dc000<BR>GPR00: 00000000 C79DDF40 C7D63450 00004000 00000001 00000000 =
C785B940 7FA18498<BR>GPR08: 00000000 00000004 00029002 00000000 22000482 =
100AFAA0 07FF5000 007FFF3C<BR>GPR16: 00000000 00000001 00000000 7FA18480 =
00000000 10195BA0 7FA18498 10195BB8<BR>GPR24: 00000000 00000001 30021800 =
7FD75C50 00000000 00000000 10047234 7FD745E0<BR>NIP [C0002420] =
do_user_signal+0x8/0xc4<BR>LR [C00022C4] =
ret_from_mcheck_exc+0x0/0xe0<BR>Call Trace:<BR>[C79DDF40] [C00022C4] =
ret_from_mcheck_exc+0x0/0xe0 (unreliable)<BR>Instruction =
dump:<BR>48182ccd 3d400002 614a1002 7d400124 54290024 81290024 71200008 =
40a2ffdc<BR>71200004 4182fc74 614a8000 7d400124 &lt;806100b0&gt; =
70600001 41820058 =
91a10044<BR>8&lt;--------------------------------------------------------=
------------</DIV>=0A=
<DIV></FONT>&nbsp;</DIV></BODY></HTML>
------_=_NextPart_001_01C7B3FF.0BB2ECBA--
