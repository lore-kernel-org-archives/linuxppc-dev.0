Return-Path: <Atit_Shah@satyam.com>
Received: from vvamail.satyam.com (vvamail.satyam.com [208.220.247.17])
	by ozlabs.org (Postfix) with ESMTP id 3476867A8C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 03:23:09 +1000 (EST)
Message-ID: <A44765C986F8D411995B00B0D0795F4B3A828119@hhtnt002>
From: Atit_Shah <Atit_Shah@satyam.com>
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	linuxppc-embedded@ozlabs.org
Date: Thu, 31 Mar 2005 22:06:53 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5360F.D89ABD9A"
Subject: RE: Linux crashes during memory mapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5360F.D89ABD9A
Content-Type: text/plain

1. SYPCR is DISABLED for our board

2. What do you mean when you say "RAM is correctly mapped" are you talking
about the functioning of RAM or if there is an overlapping between various
regions or some thing else? 
The power on self test of RAM through u-boot and RAM test through Code
Warrior have been successful.

3. Sorry I sent in the wrong log_buffer contents, the bd_info is been passed
correctly from u-boot to linux. Below is the log_buffer which says "Oops
Kernel Access of Bad Area"

00177e34: 3c363e4d 656d6f72 79204241 54206d61    <6>Memory BAT ma
00177e44: 7070696e 673a2042 7070696e 673a2042    pping: Bpping: B
00177e54: 622c2042 4154333d 33324d62 2c207265    b, BAT3=32Mb, re
00177e64: 73696475 616c3a20 304d620a 3c343e4f    sidual: 0Mb.<4>O
00177e74: 6f70733a 206b6572 6e656c20 61636365    ops: kernel acce
00177e84: 7373206f 66206261 64206172 65612c20    ss of bad area, 
00177e94: 7369673a 2031310a 3c343e4e 49503a20    sig: 11.<4>NIP: 
00177ea4: 30303030 30303030 20584552 3a203030    00000000 XER: 00
00177eb4: 30303030 3030204c 523a2030 30303030    000000 LR: 00000
00177ec4: 30303020 53503a20 30303030 30303030    000 SP: 00000000
00177ed4: 20524547 533a2063 30313530 30303020     REGS: c0150000 
00177ee4: 54524150 3a203030 30302020 20204e6f    TRAP: 0000    No
00177ef4: 74207461 696e7465 640a3c34 3e4d5352    t tainted.<4>MSR
00177f04: 3a203030 30303030 30302045 453a2030    : 00000000 EE: 0
00177f14: 2050523a 20302046 503a2030 204d453a     PR: 0 FP: 0 ME:
00177f24: 20302049 522f4452 3a203030 0a3c343e     0 IR/DR: 00.<4>
00177f34: 5441534b 203d2063 30313466 3437305b    TASK = c014f470[
00177f44: 305d2027 73776170 70657227 204c6173    0] 'swapper' Las
00177f54: 74207379 7363616c 6c3a2030 200a3c34    t syscall: 0 .<4
00177f64: 3e6c6173 74206d61 74682030 30303030    >last math 00000
00177f74: 30303020 6c617374 20616c74 69766563    000 last altivec
00177f84: 20303030 30303030 300a3c34 3e43616c     00000000.<4>Cal
00177f94: 6c206261 636b7472 6163653a 20303030    l backtrace: 000
00177fa4: 30303030 34200a3c 343e4f6f 70733a20    00004 .<4>Oops: 
00177fb4: 6b65726e 656c2061 63636573 73206f66    kernel access of
00177fc4: 20626164 20617265 612c2073 69673a20     bad area, sig: 
00177fd4: 31310a3c 343e4e49 503a2030 30303030    11.<4>NIP: 00000
00177fe4: 30303020 5845523a 20303030 30303030    000 XER: 0000000
00177ff4: 30204c52 3a203030 30303030 30302053    0 LR: 00000000 S
00178004: 503a2030 30303030 30303020 52454753    P: 00000000 REGS
00178014: 3a206330 31353030 30302054 5241503a    : c0150000 TRAP:
00178024: 20303030 30202020 204e6f74 20746169     0000    Not tai
00178034: 6e746564 0a3c343e 4d53523a 20303030    nted.<4>MSR: 000
00178044: 30303030 30204545 3a203020 50523a20    00000 EE: 0 PR: 
00178054: 30204650 3a203020 4d453a20 30204952    0 FP: 0 ME: 0 IR
00178064: 2f44523a 2030300a 3c343e54 41534b20    /DR: 00.<4>TASK 
00178074: 3d206330 31346634 37305b30 5d202773    = c014f470[0] 's
00178084: 77617070 65722720 4c617374 20737973    wapper' Last sys
00178094: 63616c6c 3a203020 0a3c343e 6c617374    call: 0 .<4>last
001780a4: 206d6174 68203030 30303030 3030206c     math 00000000 l
001780b4: 61737420 616c7469 76656320 30303030    ast altivec 0000
001780c4: 30303030 0a3c343e 43616c6c 20626163    0000.<4>Call bac
001780d4: 6b747261 63653a20 30303030 30303034    ktrace: 00000004
001780e4: 200a3c34 3e4f6f70 733a206b 65726e65     .<4>Oops: kerne
001780f4: 6c206163 63657373 206f6620 62616420    l access of bad 
00178104: 61726561 2c207369 673a2031 310a3c34    area, sig: 11.<4
00178114: 3e4e4950 3a203030 30303030 30312058    >NIP: 00000001 X
00178124: 45523a20 30303030 30303030 204c523a    ER: 00000000 LR:
00178134: 20433031 35303044 30205350 3a203030     C01500D0 SP: 00
00178144: 30303030 30302052 4547533a 20633031    000000 REGS: c01
00178154: 35303030 30205452 41503a20 31303332    50000 TRAP: 1032
00178164: 20202020 4e6f7420 7461696e 7465640a        Not tainted.
00178174: 3c343e4d 53523a20 66666666 66666666    <4>MSR: ffffffff
00178184: 2045453a 20312050 523a2031 2046503a     EE: 1 PR: 1 FP:
00178194: 2031204d 453a2031 2049522f 44523a20     1 ME: 1 IR/DR: 
001781a4: 31310a3c 343e5441 534b203d 20633031    11.<4>TASK = c01
001781b4: 34663437 305b305d 20277377 61707065    4f470[0] 'swappe
001781c4: 7227204c 61737420 73797363 616c6c3a    r' Last syscall:
001781d4: 2030200a 3c343e6c 61737420 6d617468     0 .<4>last math
001781e4: 20303030 30303030 30206c61 73742061     00000000 last a
001781f4: 6c746976 65632030 30303030 3030300a    ltivec 00000000.
00178204: 3c343eff ffffffc0 1502c0c0 15024361    <4>...........Ca
00178214: 6c6c2062 61636b74 72616365 3a203030    ll backtrace: 00
00178224: 30303030 3034200a 3c343e4f 6f70733a    000004 .<4>Oops:
00178234: 206b6572 6e656c20 61636365 7373206f     kernel access o
00178244: 66206261 64206172 65612c20 7369673a    f bad area, sig:
00178254: 2031310a 3c343e4e 49503a20 30303030     11.<4>NIP: 0000
00178264: 30303031 20584552 3a203030 30303030    0001 XER: 000000
00178274: 3030204c 523a2043 30313530 30443020    00 LR: C01500D0 
00178284: 53503a20 46464646 46434330 20524547    SP: FFFFFCC0 REG
00178294: 533a2063 30313530 30303020 54524150    S: c0150000 TRAP
001782a4: 3a203130 33322020 20204e6f 74207461    : 1032    Not ta
001782b4: 696e7465 640a3c34 3e4d5352 3a206666    inted.<4>MSR: ff
001782c4: 66666666 66662045 453a2031 2050523a    ffffff EE: 1 PR:
001782d4: 20312046 503a2031 204d453a 20312049     1 FP: 1 ME: 1 I
001782e4: 522f4452 3a203131 0a3c343e 5441534b    R/DR: 11.<4>TASK
001782f4: 203d2063 30313466 3437305b 305d2027     = c014f470[0] '
00178304: 73772720 4c617374 20737973 63616c6c    sw' Last syscall
00178314: 3a202d31 30373337 31383034 30200a3c    : -1073718040 .<
00178324: 343e6c61 7374206d 61746820 30303030    4>last math 0000
00178334: 30303030 206c6173 7420616c 74697665    0000 last altive
00178344: 63203030 30303030 30300a3c 343effff    c 00000000.<4>..
00178354: ffffc015 02c0c015 02000000 00000000    ................

4. Below is our register values:

HRCW 	 	0x0c42020a
IMMR		0xF0000000
SYPCR		0xffff0681
SCCR		0x00000001
RMR		0x00000000		
BCR		0x00100000 
HID0 		0x0000cc88 /*Initial*/
HID0 		0x80000008 /*Final*/

# Flash - CS0 ----------------
BR0			0xFe001801    
OR0 			0xFe000880 

# SDRAM - CS1 ----------------
OR1			0xFE002EC0 
BR1			0x00000041 


PSRT			0x27 
MPTPR			0x2500

# cbr refresh
PSDMR			0xC24A24A2 
SIUMCR		0x01230200	

MSR			0x0000B942

Awaiting prompt reply, 
Atit

-----Original Message-----
From: Steven Blakeslee [mailto:BlakesleeS@embeddedplanet.com] 
Sent: Thursday, March 31, 2005 6:23 PM
To: Atit_Shah; linuxppc-embedded@ozlabs.org
Subject: RE: Linux crashes during memory mapping

> 	I do not have any problem with the functioning of U-Boot but
Linux crashes after       
> printing "Uncompressing Kernel ... OK" and then it seems that nothing
is happening.

Do you have the SYPCR(serial watch dog timer) disabled?

	


>	3. The memory map of the VPN Board (MY BOARD) is as folllows: 
>
===================================================================== 
>	Memory Region            Size
Address Range                         
>
====================================================================== 
>	SDRAM                    32MByte                      0000_0000
-- 01FF_FFFF                  
>	Flash                    32MByte                      FF00_0000
-- FFFF_FFFF   

Have you done a full test to make sure your RAM is correctly mapped?

	  

>	This is what the console log buffer has shown: 
>
================================================================= 
>	md 0x00177e34 
>
>	00177e34: 3c363e6d 73746172 743d303c 363e6d73
<6>mstart=0<6>ms 
>	00177e44: 697a653d 303c363e 66737461 72743d30
ize=0<6>fstart=0 
>	00177e54: 3c363e66 73697a65 3d303c36 3e696d6d
<6>fsize=0<6>imm 
>	00177e64: 723d303c 363e626f 74666c61 673d303c
r=0<6>botflag=0< 
>	00177e74: 363e6970 6164643d 303c363e 65616464
6>ipadd=0<6>eadd 
>	00177e84: 3d633031 35303032 383c363e 65737065
=c0150028<6>espe 
>	00177e94: 643d303c 363e696e 6974663d 303c363e
d=0<6>initf=0<6> 
>	00177ea4: 62757366 3d303c36 3e63706d 663d303c
busf=0<6>cpmf=0< 
>	00177eb4: 363e6272 67663d30 3c363e73 6363663d
6>brgf=0<6>sccf= 
>	00177ec4: 303c363e 76636f3d 303c363e 62617564
0<6>vco=0<6>baud 
>	00177ed4: 3d304f6f 70733a20 6b65726e 656c2061    =0Oops: kernel
a 
	
These values do not look correct.  Everything is zero.
************************************************************************** 
This email (including any attachments) is intended for the sole use of the
intended recipient/s and may contain material that is CONFIDENTIAL AND
PRIVATE COMPANY INFORMATION. Any review or reliance by others or copying or
distribution or forwarding of any or all of the contents in this message is
STRICTLY PROHIBITED. If you are not the intended recipient, please contact
the sender by email and delete all copies; your cooperation in this regard
is appreciated.
**************************************************************************

------_=_NextPart_001_01C5360F.D89ABD9A
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.2">
<TITLE>RE: Linux crashes during memory mapping</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>1. SYPCR is DISABLED for our board</FONT>
</P>

<P><FONT SIZE=3D2>2. What do you mean when you say &quot;RAM is =
correctly mapped&quot; are you talking about the functioning of RAM or =
if there is an overlapping between various regions or some thing else? =
</FONT></P>

<P><FONT SIZE=3D2>The power on self test of RAM through u-boot and RAM =
test through Code Warrior have been successful.</FONT>
</P>

<P><FONT SIZE=3D2>3. Sorry I sent in the wrong log_buffer contents, the =
bd_info is been passed correctly from u-boot to linux. Below is the =
log_buffer which says &quot;Oops Kernel Access of Bad =
Area&quot;</FONT></P>

<P><FONT SIZE=3D2>00177e34: 3c363e4d 656d6f72 79204241 =
54206d61&nbsp;&nbsp;&nbsp; &lt;6&gt;Memory BAT ma</FONT>
<BR><FONT SIZE=3D2>00177e44: 7070696e 673a2042 7070696e =
673a2042&nbsp;&nbsp;&nbsp; pping: Bpping: B</FONT>
<BR><FONT SIZE=3D2>00177e54: 622c2042 4154333d 33324d62 =
2c207265&nbsp;&nbsp;&nbsp; b, BAT3=3D32Mb, re</FONT>
<BR><FONT SIZE=3D2>00177e64: 73696475 616c3a20 304d620a =
3c343e4f&nbsp;&nbsp;&nbsp; sidual: 0Mb.&lt;4&gt;O</FONT>
<BR><FONT SIZE=3D2>00177e74: 6f70733a 206b6572 6e656c20 =
61636365&nbsp;&nbsp;&nbsp; ops: kernel acce</FONT>
<BR><FONT SIZE=3D2>00177e84: 7373206f 66206261 64206172 =
65612c20&nbsp;&nbsp;&nbsp; ss of bad area, </FONT>
<BR><FONT SIZE=3D2>00177e94: 7369673a 2031310a 3c343e4e =
49503a20&nbsp;&nbsp;&nbsp; sig: 11.&lt;4&gt;NIP: </FONT>
<BR><FONT SIZE=3D2>00177ea4: 30303030 30303030 20584552 =
3a203030&nbsp;&nbsp;&nbsp; 00000000 XER: 00</FONT>
<BR><FONT SIZE=3D2>00177eb4: 30303030 3030204c 523a2030 =
30303030&nbsp;&nbsp;&nbsp; 000000 LR: 00000</FONT>
<BR><FONT SIZE=3D2>00177ec4: 30303020 53503a20 30303030 =
30303030&nbsp;&nbsp;&nbsp; 000 SP: 00000000</FONT>
<BR><FONT SIZE=3D2>00177ed4: 20524547 533a2063 30313530 =
30303020&nbsp;&nbsp;&nbsp;&nbsp; REGS: c0150000 </FONT>
<BR><FONT SIZE=3D2>00177ee4: 54524150 3a203030 30302020 =
20204e6f&nbsp;&nbsp;&nbsp; TRAP: 0000&nbsp;&nbsp;&nbsp; No</FONT>
<BR><FONT SIZE=3D2>00177ef4: 74207461 696e7465 640a3c34 =
3e4d5352&nbsp;&nbsp;&nbsp; t tainted.&lt;4&gt;MSR</FONT>
<BR><FONT SIZE=3D2>00177f04: 3a203030 30303030 30302045 =
453a2030&nbsp;&nbsp;&nbsp; : 00000000 EE: 0</FONT>
<BR><FONT SIZE=3D2>00177f14: 2050523a 20302046 503a2030 =
204d453a&nbsp;&nbsp;&nbsp;&nbsp; PR: 0 FP: 0 ME:</FONT>
<BR><FONT SIZE=3D2>00177f24: 20302049 522f4452 3a203030 =
0a3c343e&nbsp;&nbsp;&nbsp;&nbsp; 0 IR/DR: 00.&lt;4&gt;</FONT>
<BR><FONT SIZE=3D2>00177f34: 5441534b 203d2063 30313466 =
3437305b&nbsp;&nbsp;&nbsp; TASK =3D c014f470[</FONT>
<BR><FONT SIZE=3D2>00177f44: 305d2027 73776170 70657227 =
204c6173&nbsp;&nbsp;&nbsp; 0] 'swapper' Las</FONT>
<BR><FONT SIZE=3D2>00177f54: 74207379 7363616c 6c3a2030 =
200a3c34&nbsp;&nbsp;&nbsp; t syscall: 0 .&lt;4</FONT>
<BR><FONT SIZE=3D2>00177f64: 3e6c6173 74206d61 74682030 =
30303030&nbsp;&nbsp;&nbsp; &gt;last math 00000</FONT>
<BR><FONT SIZE=3D2>00177f74: 30303020 6c617374 20616c74 =
69766563&nbsp;&nbsp;&nbsp; 000 last altivec</FONT>
<BR><FONT SIZE=3D2>00177f84: 20303030 30303030 300a3c34 =
3e43616c&nbsp;&nbsp;&nbsp;&nbsp; 00000000.&lt;4&gt;Cal</FONT>
<BR><FONT SIZE=3D2>00177f94: 6c206261 636b7472 6163653a =
20303030&nbsp;&nbsp;&nbsp; l backtrace: 000</FONT>
<BR><FONT SIZE=3D2>00177fa4: 30303030 34200a3c 343e4f6f =
70733a20&nbsp;&nbsp;&nbsp; 00004 .&lt;4&gt;Oops: </FONT>
<BR><FONT SIZE=3D2>00177fb4: 6b65726e 656c2061 63636573 =
73206f66&nbsp;&nbsp;&nbsp; kernel access of</FONT>
<BR><FONT SIZE=3D2>00177fc4: 20626164 20617265 612c2073 =
69673a20&nbsp;&nbsp;&nbsp;&nbsp; bad area, sig: </FONT>
<BR><FONT SIZE=3D2>00177fd4: 31310a3c 343e4e49 503a2030 =
30303030&nbsp;&nbsp;&nbsp; 11.&lt;4&gt;NIP: 00000</FONT>
<BR><FONT SIZE=3D2>00177fe4: 30303020 5845523a 20303030 =
30303030&nbsp;&nbsp;&nbsp; 000 XER: 0000000</FONT>
<BR><FONT SIZE=3D2>00177ff4: 30204c52 3a203030 30303030 =
30302053&nbsp;&nbsp;&nbsp; 0 LR: 00000000 S</FONT>
<BR><FONT SIZE=3D2>00178004: 503a2030 30303030 30303020 =
52454753&nbsp;&nbsp;&nbsp; P: 00000000 REGS</FONT>
<BR><FONT SIZE=3D2>00178014: 3a206330 31353030 30302054 =
5241503a&nbsp;&nbsp;&nbsp; : c0150000 TRAP:</FONT>
<BR><FONT SIZE=3D2>00178024: 20303030 30202020 204e6f74 =
20746169&nbsp;&nbsp;&nbsp;&nbsp; 0000&nbsp;&nbsp;&nbsp; Not tai</FONT>
<BR><FONT SIZE=3D2>00178034: 6e746564 0a3c343e 4d53523a =
20303030&nbsp;&nbsp;&nbsp; nted.&lt;4&gt;MSR: 000</FONT>
<BR><FONT SIZE=3D2>00178044: 30303030 30204545 3a203020 =
50523a20&nbsp;&nbsp;&nbsp; 00000 EE: 0 PR: </FONT>
<BR><FONT SIZE=3D2>00178054: 30204650 3a203020 4d453a20 =
30204952&nbsp;&nbsp;&nbsp; 0 FP: 0 ME: 0 IR</FONT>
<BR><FONT SIZE=3D2>00178064: 2f44523a 2030300a 3c343e54 =
41534b20&nbsp;&nbsp;&nbsp; /DR: 00.&lt;4&gt;TASK </FONT>
<BR><FONT SIZE=3D2>00178074: 3d206330 31346634 37305b30 =
5d202773&nbsp;&nbsp;&nbsp; =3D c014f470[0] 's</FONT>
<BR><FONT SIZE=3D2>00178084: 77617070 65722720 4c617374 =
20737973&nbsp;&nbsp;&nbsp; wapper' Last sys</FONT>
<BR><FONT SIZE=3D2>00178094: 63616c6c 3a203020 0a3c343e =
6c617374&nbsp;&nbsp;&nbsp; call: 0 .&lt;4&gt;last</FONT>
<BR><FONT SIZE=3D2>001780a4: 206d6174 68203030 30303030 =
3030206c&nbsp;&nbsp;&nbsp;&nbsp; math 00000000 l</FONT>
<BR><FONT SIZE=3D2>001780b4: 61737420 616c7469 76656320 =
30303030&nbsp;&nbsp;&nbsp; ast altivec 0000</FONT>
<BR><FONT SIZE=3D2>001780c4: 30303030 0a3c343e 43616c6c =
20626163&nbsp;&nbsp;&nbsp; 0000.&lt;4&gt;Call bac</FONT>
<BR><FONT SIZE=3D2>001780d4: 6b747261 63653a20 30303030 =
30303034&nbsp;&nbsp;&nbsp; ktrace: 00000004</FONT>
<BR><FONT SIZE=3D2>001780e4: 200a3c34 3e4f6f70 733a206b =
65726e65&nbsp;&nbsp;&nbsp;&nbsp; .&lt;4&gt;Oops: kerne</FONT>
<BR><FONT SIZE=3D2>001780f4: 6c206163 63657373 206f6620 =
62616420&nbsp;&nbsp;&nbsp; l access of bad </FONT>
<BR><FONT SIZE=3D2>00178104: 61726561 2c207369 673a2031 =
310a3c34&nbsp;&nbsp;&nbsp; area, sig: 11.&lt;4</FONT>
<BR><FONT SIZE=3D2>00178114: 3e4e4950 3a203030 30303030 =
30312058&nbsp;&nbsp;&nbsp; &gt;NIP: 00000001 X</FONT>
<BR><FONT SIZE=3D2>00178124: 45523a20 30303030 30303030 =
204c523a&nbsp;&nbsp;&nbsp; ER: 00000000 LR:</FONT>
<BR><FONT SIZE=3D2>00178134: 20433031 35303044 30205350 =
3a203030&nbsp;&nbsp;&nbsp;&nbsp; C01500D0 SP: 00</FONT>
<BR><FONT SIZE=3D2>00178144: 30303030 30302052 4547533a =
20633031&nbsp;&nbsp;&nbsp; 000000 REGS: c01</FONT>
<BR><FONT SIZE=3D2>00178154: 35303030 30205452 41503a20 =
31303332&nbsp;&nbsp;&nbsp; 50000 TRAP: 1032</FONT>
<BR><FONT SIZE=3D2>00178164: 20202020 4e6f7420 7461696e =
7465640a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not tainted.</FONT>
<BR><FONT SIZE=3D2>00178174: 3c343e4d 53523a20 66666666 =
66666666&nbsp;&nbsp;&nbsp; &lt;4&gt;MSR: ffffffff</FONT>
<BR><FONT SIZE=3D2>00178184: 2045453a 20312050 523a2031 =
2046503a&nbsp;&nbsp;&nbsp;&nbsp; EE: 1 PR: 1 FP:</FONT>
<BR><FONT SIZE=3D2>00178194: 2031204d 453a2031 2049522f =
44523a20&nbsp;&nbsp;&nbsp;&nbsp; 1 ME: 1 IR/DR: </FONT>
<BR><FONT SIZE=3D2>001781a4: 31310a3c 343e5441 534b203d =
20633031&nbsp;&nbsp;&nbsp; 11.&lt;4&gt;TASK =3D c01</FONT>
<BR><FONT SIZE=3D2>001781b4: 34663437 305b305d 20277377 =
61707065&nbsp;&nbsp;&nbsp; 4f470[0] 'swappe</FONT>
<BR><FONT SIZE=3D2>001781c4: 7227204c 61737420 73797363 =
616c6c3a&nbsp;&nbsp;&nbsp; r' Last syscall:</FONT>
<BR><FONT SIZE=3D2>001781d4: 2030200a 3c343e6c 61737420 =
6d617468&nbsp;&nbsp;&nbsp;&nbsp; 0 .&lt;4&gt;last math</FONT>
<BR><FONT SIZE=3D2>001781e4: 20303030 30303030 30206c61 =
73742061&nbsp;&nbsp;&nbsp;&nbsp; 00000000 last a</FONT>
<BR><FONT SIZE=3D2>001781f4: 6c746976 65632030 30303030 =
3030300a&nbsp;&nbsp;&nbsp; ltivec 00000000.</FONT>
<BR><FONT SIZE=3D2>00178204: 3c343eff ffffffc0 1502c0c0 =
15024361&nbsp;&nbsp;&nbsp; &lt;4&gt;...........Ca</FONT>
<BR><FONT SIZE=3D2>00178214: 6c6c2062 61636b74 72616365 =
3a203030&nbsp;&nbsp;&nbsp; ll backtrace: 00</FONT>
<BR><FONT SIZE=3D2>00178224: 30303030 3034200a 3c343e4f 6f70733a&nbsp;&n=
bsp;&nbsp; 000004 .&lt;4&gt;Oops:</FONT>
<BR><FONT SIZE=3D2>00178234: 206b6572 6e656c20 61636365 =
7373206f&nbsp;&nbsp;&nbsp;&nbsp; kernel access o</FONT>
<BR><FONT SIZE=3D2>00178244: 66206261 64206172 65612c20 =
7369673a&nbsp;&nbsp;&nbsp; f bad area, sig:</FONT>
<BR><FONT SIZE=3D2>00178254: 2031310a 3c343e4e 49503a20 =
30303030&nbsp;&nbsp;&nbsp;&nbsp; 11.&lt;4&gt;NIP: 0000</FONT>
<BR><FONT SIZE=3D2>00178264: 30303031 20584552 3a203030 =
30303030&nbsp;&nbsp;&nbsp; 0001 XER: 000000</FONT>
<BR><FONT SIZE=3D2>00178274: 3030204c 523a2043 30313530 =
30443020&nbsp;&nbsp;&nbsp; 00 LR: C01500D0 </FONT>
<BR><FONT SIZE=3D2>00178284: 53503a20 46464646 46434330 =
20524547&nbsp;&nbsp;&nbsp; SP: FFFFFCC0 REG</FONT>
<BR><FONT SIZE=3D2>00178294: 533a2063 30313530 30303020 =
54524150&nbsp;&nbsp;&nbsp; S: c0150000 TRAP</FONT>
<BR><FONT SIZE=3D2>001782a4: 3a203130 33322020 20204e6f =
74207461&nbsp;&nbsp;&nbsp; : 1032&nbsp;&nbsp;&nbsp; Not ta</FONT>
<BR><FONT SIZE=3D2>001782b4: 696e7465 640a3c34 3e4d5352 =
3a206666&nbsp;&nbsp;&nbsp; inted.&lt;4&gt;MSR: ff</FONT>
<BR><FONT SIZE=3D2>001782c4: 66666666 66662045 453a2031 =
2050523a&nbsp;&nbsp;&nbsp; ffffff EE: 1 PR:</FONT>
<BR><FONT SIZE=3D2>001782d4: 20312046 503a2031 204d453a =
20312049&nbsp;&nbsp;&nbsp;&nbsp; 1 FP: 1 ME: 1 I</FONT>
<BR><FONT SIZE=3D2>001782e4: 522f4452 3a203131 0a3c343e =
5441534b&nbsp;&nbsp;&nbsp; R/DR: 11.&lt;4&gt;TASK</FONT>
<BR><FONT SIZE=3D2>001782f4: 203d2063 30313466 3437305b =
305d2027&nbsp;&nbsp;&nbsp;&nbsp; =3D c014f470[0] '</FONT>
<BR><FONT SIZE=3D2>00178304: 73772720 4c617374 20737973 =
63616c6c&nbsp;&nbsp;&nbsp; sw' Last syscall</FONT>
<BR><FONT SIZE=3D2>00178314: 3a202d31 30373337 31383034 =
30200a3c&nbsp;&nbsp;&nbsp; : -1073718040 .&lt;</FONT>
<BR><FONT SIZE=3D2>00178324: 343e6c61 7374206d 61746820 =
30303030&nbsp;&nbsp;&nbsp; 4&gt;last math 0000</FONT>
<BR><FONT SIZE=3D2>00178334: 30303030 206c6173 7420616c =
74697665&nbsp;&nbsp;&nbsp; 0000 last altive</FONT>
<BR><FONT SIZE=3D2>00178344: 63203030 30303030 30300a3c =
343effff&nbsp;&nbsp;&nbsp; c 00000000.&lt;4&gt;..</FONT>
<BR><FONT SIZE=3D2>00178354: ffffc015 02c0c015 02000000 =
00000000&nbsp;&nbsp;&nbsp; ................</FONT>
</P>

<P><FONT SIZE=3D2>4. Below is our register values:</FONT>
</P>

<P><FONT SIZE=3D2>HRCW &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0c42020a</FONT>
<BR><FONT SIZE=3D2>IMMR&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xF0000000</FONT>
<BR><FONT SIZE=3D2>SYPCR&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xffff0681</FONT>
<BR><FONT SIZE=3D2>SCCR&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001</FONT>
<BR><FONT SIZE=3D2>RMR&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>BCR&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00100000 </FONT>
<BR><FONT SIZE=3D2>HID0 &nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000cc88 =
/*Initial*/</FONT>
<BR><FONT SIZE=3D2>HID0 &nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000008 /*Final*/</FONT>
</P>

<P><FONT SIZE=3D2># Flash - CS0 ----------------</FONT>
<BR><FONT SIZE=3D2>BR0&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFe001801&nbsp;&nbsp;&nbsp; =
</FONT>
<BR><FONT SIZE=3D2>OR0 &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFe000880 </FONT>
</P>

<P><FONT SIZE=3D2># SDRAM - CS1 ----------------</FONT>
<BR><FONT SIZE=3D2>OR1&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFE002EC0 </FONT>
<BR><FONT SIZE=3D2>BR1&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000041 </FONT>
</P>
<BR>

<P><FONT SIZE=3D2>PSRT&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x27 </FONT>
<BR><FONT SIZE=3D2>MPTPR&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2500</FONT>
</P>

<P><FONT SIZE=3D2># cbr refresh</FONT>
<BR><FONT SIZE=3D2>PSDMR&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xC24A24A2 </FONT>
<BR><FONT SIZE=3D2>SIUMCR&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x01230200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2>MSR&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000B942</FONT>
</P>

<P><FONT SIZE=3D2>Awaiting prompt reply, </FONT>
<BR><FONT SIZE=3D2>Atit</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Steven Blakeslee [<A =
HREF=3D"mailto:BlakesleeS@embeddedplanet.com">mailto:BlakesleeS@embedded=
planet.com</A>] </FONT>
<BR><FONT SIZE=3D2>Sent: Thursday, March 31, 2005 6:23 PM</FONT>
<BR><FONT SIZE=3D2>To: Atit_Shah; linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Subject: RE: Linux crashes during memory =
mapping</FONT>
</P>

<P><FONT SIZE=3D2>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I do not have any =
problem with the functioning of U-Boot but</FONT>
<BR><FONT SIZE=3D2>Linux crashes =
after&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; printing &quot;Uncompressing Kernel ... =
OK&quot; and then it seems that nothing</FONT>
<BR><FONT SIZE=3D2>is happening.</FONT>
</P>

<P><FONT SIZE=3D2>Do you have the SYPCR(serial watch dog timer) =
disabled?</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</P>
<BR>

<P><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. The =
memory map of the VPN Board (MY BOARD) is as folllows: </FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT =
SIZE=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory =
Region&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Size</FONT>
<BR><FONT SIZE=3D2>Address =
Range&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT =
SIZE=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDRAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
32MByte&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0000_0000</FONT>
<BR><FONT SIZE=3D2>-- =
01FF_FFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Flash&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
32MByte&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF00_0000</FONT>
<BR><FONT SIZE=3D2>-- FFFF_FFFF&nbsp;&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2>Have you done a full test to make sure your RAM is =
correctly mapped?</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>&nbsp; =
</FONT>
</P>

<P><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This is what =
the console log buffer has shown: </FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT =
SIZE=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; md =
0x00177e34 </FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177e34: =
3c363e6d 73746172 743d303c 363e6d73</FONT>
<BR><FONT SIZE=3D2>&lt;6&gt;mstart=3D0&lt;6&gt;ms </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177e44: =
697a653d 303c363e 66737461 72743d30</FONT>
<BR><FONT SIZE=3D2>ize=3D0&lt;6&gt;fstart=3D0 </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177e54: =
3c363e66 73697a65 3d303c36 3e696d6d</FONT>
<BR><FONT SIZE=3D2>&lt;6&gt;fsize=3D0&lt;6&gt;imm </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177e64: =
723d303c 363e626f 74666c61 673d303c</FONT>
<BR><FONT SIZE=3D2>r=3D0&lt;6&gt;botflag=3D0&lt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177e74: =
363e6970 6164643d 303c363e 65616464</FONT>
<BR><FONT SIZE=3D2>6&gt;ipadd=3D0&lt;6&gt;eadd </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177e84: =
3d633031 35303032 383c363e 65737065</FONT>
<BR><FONT SIZE=3D2>=3Dc0150028&lt;6&gt;espe </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177e94: =
643d303c 363e696e 6974663d 303c363e</FONT>
<BR><FONT SIZE=3D2>d=3D0&lt;6&gt;initf=3D0&lt;6&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177ea4: =
62757366 3d303c36 3e63706d 663d303c</FONT>
<BR><FONT SIZE=3D2>busf=3D0&lt;6&gt;cpmf=3D0&lt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177eb4: =
363e6272 67663d30 3c363e73 6363663d</FONT>
<BR><FONT SIZE=3D2>6&gt;brgf=3D0&lt;6&gt;sccf=3D </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177ec4: =
303c363e 76636f3d 303c363e 62617564</FONT>
<BR><FONT SIZE=3D2>0&lt;6&gt;vco=3D0&lt;6&gt;baud </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00177ed4: =
3d304f6f 70733a20 6b65726e 656c2061&nbsp;&nbsp;&nbsp; =3D0Oops: =
kernel</FONT>
<BR><FONT SIZE=3D2>a </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><FONT SIZE=3D2>These values do not look correct.&nbsp; Everything =
is zero.</FONT>
<BR><FONT =
SIZE=3D2>***************************************************************=
*********** </FONT>
<BR><FONT SIZE=3D2>This email (including any attachments) is intended =
for the sole use of the intended recipient/s and may contain material =
that is CONFIDENTIAL AND PRIVATE COMPANY INFORMATION. Any review or =
reliance by others or copying or distribution or forwarding of any or =
all of the contents in this message is STRICTLY PROHIBITED. If you are =
not the intended recipient, please contact the sender by email and =
delete all copies; your cooperation in this regard is =
appreciated.</FONT></P>

<P><FONT =
SIZE=3D2>***************************************************************=
***********</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5360F.D89ABD9A--
