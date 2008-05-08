Return-Path: <hartmann@delta.uni-dortmund.de>
Received: from athene.delta.uni-dortmund.de (Athene.delta.Uni-Dortmund.DE
	[129.217.164.29]) by ozlabs.org (Postfix) with ESMTP id D00A9DE0A8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 May 2008 00:28:30 +1000 (EST)
Received: from [129.217.164.30] (eos.delta.Uni-Dortmund.DE [129.217.164.30])
	by athene.delta.uni-dortmund.de (8.11.6/8.11.6) with ESMTP id
	m48DuIF21498
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 May 2008 15:56:18 +0200
Message-ID: <48230682.8090000@delta.uni-dortmund.de>
Date: Thu, 08 May 2008 15:56:18 +0200
From: "Dr. Peter Hartmann" <hartmann@delta.uni-dortmund.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: xilinx linux on a XUPV2P
Content-Type: multipart/mixed; boundary="------------060807070001000404040607"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060807070001000404040607
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello everybody,

I am trying to get the latest Kernel (2.6.25-rc9) from git.xilinx.com running on
a XUPV2P board. I generated the hardware using JH Kelms step by step list,
skipping points 6-8 and replacing point 9 by a more modern version of doing
this. When I boot the system.ace from the CF card, the bootloader talks to me
over the RS232, but as soon as it tries to boot the kernel it hangs up.
I had 2.6.18-rc3 which I got from somebody else running this way. The reason I
intend to change is the UARTLITE driver, which seems to be included in the
latest kernel tree.
I use Platform Studio 9.1.02i which I also used for the 2.6.18 Kernel.
Has anybody yet got this to work out with 9.1.02i ??
Would it be possible for somebody to give a dummy like me the steps you took to
get it working on your board? I'm really lost here. Thanks!


Thanks in advance!

--------------060807070001000404040607
Content-Type: text/x-vcard; charset=utf-8;
 name="hartmann.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hartmann.vcf"

begin:vcard
fn:Dr. Peter Hartmann
n:Hartmann;Dr. Peter
org;quoted-printable:Universit=C3=A4t Dortmund;DELTA
adr;quoted-printable:;;Maria G=C3=B6ppert-Mayer-Str. 2;Dortmund;;44221;Deutschland
email;internet:hartmann@delta.uni-dortmund.de
tel;work:+49 231 755 5374
tel;fax:+49 231 755 5383
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------060807070001000404040607--
