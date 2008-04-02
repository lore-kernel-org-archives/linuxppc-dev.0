Return-Path: <ravi.rao@rflelect.com>
Received: from rflnotes01.rflelect.com (72-164-21-98.dia.static.qwest.net
	[72.164.21.98]) by ozlabs.org (Postfix) with ESMTP id 0CCC0DDF28
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 05:35:36 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
Subject: ppc405ep and Ready enable in EBC0_BnAP register
MIME-Version: 1.0
Message-ID: <OF39A36E1A.054DB15D-ON8525741F.00650F27-8525741F.00663A93@slpower.com>
From: ravi.rao@rflelect.com
Date: Wed, 2 Apr 2008 14:35:25 -0400
Content-Type: multipart/alternative;
	boundary="=_alternative 00663A8E8525741F_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00663A8E8525741F_=
Content-Type: text/plain; charset="US-ASCII"

Hi All,
    Our target is based on PPC405EP and we are using a TDMoIP chip on the 
peripheral bus with chipselect 2. Since the access time to the chip is not 
deterministic we are planning to use the Ready enable. By probing into 
Chipselect and ready enable bits it looks like the chip select gets 
extended untill the ready enable becomes 1 but the access crashes with a 
Bus error.
But If I just set the twt to a very high value say 20 with ready enable 
set to 0  then it works. Any pointers to understand  what is happening 
will be of great help.
####################### Screen Dump #################################
Data machine check in kernel mode.
PLB0: BEAR= 0xf8000000 ACR=   0x00000000 BESR=  0x00000000
PLB0 to OPB: BEAR= 0x01000000 BESR0= 0x00000000 BESR1= 0x00000000
Oops: machine check, sig: 7 [#5]
NIP: C90C69BC LR: C90C6AA4 CTR: 000003E0
REGS: c023ef50 TRAP: 0202   Not tainted  (2.6.21)
MSR: 00029030 <EE,ME,IR,DR>  CR: 84044408  XER: 00000007
TASK = c3fab050[666] 'cat' THREAD: c2710000
GPR00: 00000000 C2711650 C3FAB050 C2729000 C2711EAC 00000000 00000C00 
C2711EA8
GPR08: 00000000 00000040 FFFFFFFF C9400000 44044408 100A54C0 03FF9C00 
00000001
GPR16: 0000005E C01DA824 C02E7F78 C01E0C50 C2711EA8 C01E0C20 C2711EAC 
C25DC320
GPR24: C2729000 00000000 C2711F20 C90C7FF4 C2729000 C2711EA8 C2711658 
C2729000
Call Trace:
[C2711E80] [C90C6AA4]
[C2711EA0] [C009BA60]
[C2711EF0] [C0063E6C]
[C2711F10] [C00642C8]
[C2711F40] [C0002CB4]
Instruction dump:
bf210814 3b697ff4 90010834 817b006c 7c7f1b78 a00b0000 39200002 b0010008
380003ff 7c0903a6 3bc10008 7c0b4a2e <7c09f32e> 39290002 4200fff4 3c80c90c
Bus error
Thanks,
Ravishankar Govindarao
RFL Electronics Inc.
E-mail : Ravi.Rao@rflelect.com
Voice: 973.334.3100 Ext. 233
Fax: 973.334.3863
 
CONFIDENTIALITY NOTE
This e-mail, including any attachments, may contain confidential and/or 
legally privileged information.  The Information is intended only for the 
use of the individual or entity named on this e-mail .  If you are not the 
intended recipient, you are hereby notified that any disclosure, copying, 
distribution, or the taking of any action in reliance on the contents of 
this transmitted Information is strictly prohibited.  Further, if you are 
not the intended recipient, please notify us by return e-mail and delete 
the Information promptly.
 
 
 
--=_alternative 00663A8E8525741F_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi All,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; Our target is based on
PPC405EP and we are using a TDMoIP chip on the peripheral bus with chipselect
2. Since the access time to the chip is not deterministic we are planning
to use the Ready enable. By probing into Chipselect and ready enable bits
it looks like the chip select gets extended untill the ready enable becomes
1 but the access crashes with a Bus error.</font>
<br><font size=2 face="sans-serif">But If I just set the twt to a very
high value say 20 with ready enable set to 0 &nbsp;then it works. Any pointers
to understand &nbsp;what is happening will be of great help.</font>
<br><font size=2 face="sans-serif">####################### Screen Dump
#################################</font>
<br><font size=2 face="Courier New">Data machine check in kernel mode.</font>
<br><font size=2 face="Courier New">PLB0: BEAR= 0xf8000000 ACR= &nbsp;
0x00000000 BESR= &nbsp;0x00000000</font>
<br><font size=2 face="Courier New">PLB0 to OPB: BEAR= 0x01000000 BESR0=
0x00000000 BESR1= 0x00000000</font>
<br><font size=2 face="Courier New">Oops: machine check, sig: 7 [#5]</font>
<br><font size=2 face="Courier New">NIP: C90C69BC LR: C90C6AA4 CTR: 000003E0</font>
<br><font size=2 face="Courier New">REGS: c023ef50 TRAP: 0202 &nbsp; Not
tainted &nbsp;(2.6.21)</font>
<br><font size=2 face="Courier New">MSR: 00029030 &lt;EE,ME,IR,DR&gt; &nbsp;CR:
84044408 &nbsp;XER: 00000007</font>
<br><font size=2 face="Courier New">TASK = c3fab050[666] 'cat' THREAD:
c2710000</font>
<br><font size=2 face="Courier New">GPR00: 00000000 C2711650 C3FAB050 C2729000
C2711EAC 00000000 00000C00 C2711EA8</font>
<br><font size=2 face="Courier New">GPR08: 00000000 00000040 FFFFFFFF C9400000
44044408 100A54C0 03FF9C00 00000001</font>
<br><font size=2 face="Courier New">GPR16: 0000005E C01DA824 C02E7F78 C01E0C50
C2711EA8 C01E0C20 C2711EAC C25DC320</font>
<br><font size=2 face="Courier New">GPR24: C2729000 00000000 C2711F20 C90C7FF4
C2729000 C2711EA8 C2711658 C2729000</font>
<br><font size=2 face="Courier New">Call Trace:</font>
<br><font size=2 face="Courier New">[C2711E80] [C90C6AA4]</font>
<br><font size=2 face="Courier New">[C2711EA0] [C009BA60]</font>
<br><font size=2 face="Courier New">[C2711EF0] [C0063E6C]</font>
<br><font size=2 face="Courier New">[C2711F10] [C00642C8]</font>
<br><font size=2 face="Courier New">[C2711F40] [C0002CB4]</font>
<br><font size=2 face="Courier New">Instruction dump:</font>
<br><font size=2 face="Courier New">bf210814 3b697ff4 90010834 817b006c
7c7f1b78 a00b0000 39200002 b0010008</font>
<br><font size=2 face="Courier New">380003ff 7c0903a6 3bc10008 7c0b4a2e
&lt;7c09f32e&gt; 39290002 4200fff4 3c80c90c</font>
<br><font size=2 face="Courier New">Bus error</font>
<br><font size=2 face="Courier New">Thanks,<br>
</font><font size=2 face="Tms Rmn">Ravishankar Govindarao<br>
RFL Electronics Inc.<br>
E-mail</font><font size=1 face="Tms Rmn"> </font><font size=2 face="Tms Rmn">:
</font><a href=mailto:Ravi.Rao@rflelect.com><font size=2 color=blue face="Tms Rmn"><u>Ravi.Rao@rflelect.com</u></font></a>
<br><font size=2 face="Tms Rmn">Voice: 973.334.3100 Ext. 233<br>
Fax: 973.334.3863</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<div align=center>
<br><font size=2 color=blue face="Tms Rmn"><u>CONFIDENTIALITY NOTE</u></font></div>
<br><font size=1 face="Tms Rmn">This e-mail, including any attachments,
may contain confidential and/or legally privileged information.&nbsp; The
Information is intended only for the use of the individual or entity named
on this e-mail</font><font size=1 face="Tms Rmn"> </font><font size=1 face="Tms Rmn">.&nbsp;
If you are not the intended recipient, you are hereby notified that any
disclosure, copying, distribution, or the taking of any action in reliance
on the contents of this transmitted Information is strictly prohibited.&nbsp;
Further, if you are not the intended recipient, please notify us by return
e-mail and delete the Information promptly.</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=3>&nbsp;</font>
--=_alternative 00663A8E8525741F_=--
