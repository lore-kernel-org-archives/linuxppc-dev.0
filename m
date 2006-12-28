Return-Path: <Yeshvanth.NV@Lntemsys.com>
Received: from mail86.messagelabs.com (mail86.messagelabs.com [216.82.244.115])
	by ozlabs.org (Postfix) with SMTP id 1FF1CDDEFC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Dec 2006 15:31:26 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
Subject: MPC8248 SPI Driver --- Help required
MIME-Version: 1.0
Message-ID: <OF97934FB0.FC8E8F0D-ON65257252.00184675-65257252.00191496@lntemsys.com>
From: Yeshvanth NV <Yeshvanth.NV@Lntemsys.com>
Date: Thu, 28 Dec 2006 10:05:26 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 0019149165257252_="
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
--=_alternative 0019149165257252_=
Content-Type: text/plain; charset="US-ASCII"

Hello everyone,
                I am developing the SPI driver for MPC8248. I need some 
help SPI Parameter RAM functionality.
In the reference Manuel t it is given that we need to allocate memory for 
Parameter RAM in dpram and assign its address in the processor parameter 
Ram. But the few drivers which i saw is trying to get the address of the 
Parameter Rams address from the processor Parameter Ram itsef. Is the 
kernel itself allocating the space for parameter RAM and initializing the 
address?

Is there any function which can be used to allocate memory for buffers for 
transmitting and receiving data as"mpc8xx_cpm_hostalloc()" for cpm2 
module?
I didn't find this function in the cpm2.h or immap_cpm2.h files.



Thanks and regards,

Yeshvanth NV
--=_alternative 0019149165257252_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif"><br>
Hello everyone,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; I am developing the SPI driver for MPC8248.
I need some help SPI Parameter RAM functionality.</font>
<br><font size=2 face="sans-serif">In the reference Manuel t it is given
that we need to allocate memory for Parameter RAM in dpram and assign its
address in the processor parameter Ram. But the few drivers which i saw
is trying to get the address of the Parameter Rams address from the processor
Parameter Ram itsef. Is the kernel itself allocating the space for parameter
RAM and initializing the address?</font>
<br>
<br><font size=2 face="sans-serif">Is there any function which can be used
to allocate memory for buffers for transmitting and receiving data as&quot;mpc8xx_cpm_hostalloc()&quot;
for cpm2 module?</font>
<br><font size=2 face="sans-serif">I didn't find this function in the cpm2.h
or immap_cpm2.h files.</font>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">Thanks and regards,</font>
<br>
<br><font size=2 face="sans-serif">Yeshvanth NV</font>
--=_alternative 0019149165257252_=--
