Return-Path: <pritha.bhattacharya@tcs.com>
Received: from INKOLG01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id 102B868810
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 22:00:28 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: pritha.bhattacharya@tcs.com
Message-ID: <OF8DE1E835.620AF9B1-ON652570C3.001D9C79-652570C3.003087C6@tcs.com>
Date: Thu, 24 Nov 2005 14:20:05 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 00304CC6652570C3_="
Subject: 8260ADS Ethernet compilation
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00304CC6652570C3_=
Content-Type: text/plain; charset="US-ASCII"


Hi,

I have a custom board built around MPC8260ADS. I am trying to cross 
compile linux 2.4.25 for ethernet on FCC1 connected to LXT971 for the 
board. 
Installed the toolchains from Denx site. Built linux for ppc architecture. 
Then for ethernet, after selecting the proper options from the menuconfig, 
while compiling the source code gives the following error:

m8260_setup.c:62: error: `bd_t' undeclared here (not in a function)
m8260_setup.c:106: warning: `abort' was declared `extern' and later 
`static'
m8260_setup.c: In function `m8260_calibrate_decr':
m8260_setup.c:120: error: `bd_t' undeclared (first use in this function)
m8260_setup.c:120: error: (Each undeclared identifier is reported only 
once
m8260_setup.c:120: error: for each function it appears in.)
m8260_setup.c:120: error: `binfo' undeclared (first use in this function)
m8260_setup.c:120: error: parse error before ')' token
m8260_setup.c: In function `m8260_restart':
m8260_setup.c:163: error: parse error before '*' token
m8260_setup.c:163: warning: function declaration isn't a prototype
m8260_setup.c: In function `m8260_show_percpuinfo':
m8260_setup.c:201: error: `bd_t' undeclared (first use in this function)
m8260_setup.c:201: error: `bp' undeclared (first use in this function)
m8260_setup.c:203: error: parse error before ')' token
m8260_setup.c: In function `m8260_init_IRQ':
m8260_setup.c:229: error: `NR_SIU_INTS' undeclared (first use in this 
function)
m8260_setup.c: In function `m8260_find_end_of_memory':
m8260_setup.c:261: error: `bd_t' undeclared (first use in this function)
m8260_setup.c:261: error: `binfo' undeclared (first use in this function)
m8260_setup.c:264: error: parse error before ')' token
m8260_setup.c:262: warning: unused variable `__res'
m8260_setup.c: In function `platform_init':
m8260_setup.c:288: error: `bd_t' undeclared (first use in this function)
m8260_setup.c: At top level:
m8260_setup.c:106: warning: `abort' defined but not used
make[1]: *** [m8260_setup.o] Error 1
make: *** [_dir_arch/ppc/kernel] Error 2


1.I understand that bd_t is a board information structure. Which is 
defined in linux/include/asm-ppc/ppcboot.h. Somehow it is not visible to 
the linux/arch/kernel/m8260_setup.c  I dont know what I may be doing 
wrong.

2.Similarly NR_SIU_INTS, which is defined in linux/include/asm/irq.h is 
also not visible.

the third query is not on compilation errors:
3.I did not understand what __res[ ] is. I came across somewhere that it 
is the residual information which the bootloader is supposed to hand over 
to the linux. How would that be done. I could not identify in the code 
where __res is populated. 

Would be of great help to get your suggestions.


Thanks & Regards
Pritha


Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 00304CC6652570C3_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I have a custom board built around MPC8260ADS.
I am trying to cross compile linux 2.4.25 for ethernet on FCC1 connected
to LXT971 for the board. </font>
<br><font size=2 face="sans-serif">Installed the toolchains from Denx site.
Built linux for ppc architecture. Then for ethernet, after selecting the
proper options from the menuconfig, while compiling the source code gives
the following error:</font>
<br>
<br><font size=2 face="sans-serif">m8260_setup.c:62: error: `bd_t' undeclared
here (not in a function)</font>
<br><font size=2 face="sans-serif">m8260_setup.c:106: warning: `abort'
was declared `extern' and later `static'</font>
<br><font size=2 face="sans-serif">m8260_setup.c: In function `m8260_calibrate_decr':</font>
<br><font size=2 face="sans-serif">m8260_setup.c:120: error: `bd_t' undeclared
(first use in this function)</font>
<br><font size=2 face="sans-serif">m8260_setup.c:120: error: (Each undeclared
identifier is reported only once</font>
<br><font size=2 face="sans-serif">m8260_setup.c:120: error: for each function
it appears in.)</font>
<br><font size=2 face="sans-serif">m8260_setup.c:120: error: `binfo' undeclared
(first use in this function)</font>
<br><font size=2 face="sans-serif">m8260_setup.c:120: error: parse error
before ')' token</font>
<br><font size=2 face="sans-serif">m8260_setup.c: In function `m8260_restart':</font>
<br><font size=2 face="sans-serif">m8260_setup.c:163: error: parse error
before '*' token</font>
<br><font size=2 face="sans-serif">m8260_setup.c:163: warning: function
declaration isn't a prototype</font>
<br><font size=2 face="sans-serif">m8260_setup.c: In function `m8260_show_percpuinfo':</font>
<br><font size=2 face="sans-serif">m8260_setup.c:201: error: `bd_t' undeclared
(first use in this function)</font>
<br><font size=2 face="sans-serif">m8260_setup.c:201: error: `bp' undeclared
(first use in this function)</font>
<br><font size=2 face="sans-serif">m8260_setup.c:203: error: parse error
before ')' token</font>
<br><font size=2 face="sans-serif">m8260_setup.c: In function `m8260_init_IRQ':</font>
<br><font size=2 face="sans-serif">m8260_setup.c:229: error: `NR_SIU_INTS'
undeclared (first use in this function)</font>
<br><font size=2 face="sans-serif">m8260_setup.c: In function `m8260_find_end_of_memory':</font>
<br><font size=2 face="sans-serif">m8260_setup.c:261: error: `bd_t' undeclared
(first use in this function)</font>
<br><font size=2 face="sans-serif">m8260_setup.c:261: error: `binfo' undeclared
(first use in this function)</font>
<br><font size=2 face="sans-serif">m8260_setup.c:264: error: parse error
before ')' token</font>
<br><font size=2 face="sans-serif">m8260_setup.c:262: warning: unused variable
`__res'</font>
<br><font size=2 face="sans-serif">m8260_setup.c: In function `platform_init':</font>
<br><font size=2 face="sans-serif">m8260_setup.c:288: error: `bd_t' undeclared
(first use in this function)</font>
<br><font size=2 face="sans-serif">m8260_setup.c: At top level:</font>
<br><font size=2 face="sans-serif">m8260_setup.c:106: warning: `abort'
defined but not used</font>
<br><font size=2 face="sans-serif">make[1]: *** [m8260_setup.o] Error 1</font>
<br><font size=2 face="sans-serif">make: *** [_dir_arch/ppc/kernel] Error
2</font>
<br>
<br>
<br><font size=2 face="sans-serif">1.I understand that bd_t is a board
information structure. Which is defined in linux/include/asm-ppc/ppcboot.h.
Somehow it is not visible to the linux/arch/kernel/m8260_setup.c &nbsp;I
dont know what I may be doing wrong.</font>
<br>
<br><font size=2 face="sans-serif">2.Similarly NR_SIU_INTS, which is defined
in linux/include/asm/irq.h is also not visible.</font>
<br>
<br><font size=2 face="sans-serif">the third query is not on compilation
errors:</font>
<br><font size=2 face="sans-serif">3.I did not understand what __res[ ]
is. I came across somewhere that it is the residual information which the
bootloader is supposed to hand over to the linux. How would that be done.
I could not identify in the code where __res is populated. </font>
<br>
<br><font size=2 face="sans-serif">Would be of great help to get your suggestions.</font>
<br>
<br>
<br><font size=2 face="sans-serif">Thanks &amp; Regards<br>
Pritha<br>
</font>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 00304CC6652570C3_=--
