Return-Path: <cclo@astri.org>
Received: from asiwss02.astri.org (mail2.astri.org [203.198.202.21])
	by ozlabs.org (Postfix) with ESMTP id B663F67BCB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 11:28:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Subject: RE: Wireless Linux(802.11) for Embedded PowerPC
Date: Wed, 6 Sep 2006 09:30:00 +0800
Message-ID: <A7B1E4DD46AA7046A4398F745240F29402737D64@ASPROEXG.astri.local>
From: "Chun Chung Lo" <cclo@astri.org>
To: <wei.li4@elf.mcgill.ca>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I have also done a such project last year. I used a MPC860SR processor
card, plus an extra tailor-made carrier board (just extend the PCMCIA
interface from the processor card). The design is simple, I just
followed the reference design suggested by Freescale MPC860 user manual.
You can get this manual on Freescale's website.

Then I used a Intersil Prism2 compatible PCMCIA WLAN card (may be a
Compact Flash WLAN card is also OK, but I have never tried this) and
plug into the PCMCIA socket of the carrier board.=0D

In the whole project, I used ELDK 3.0 as my software development
platform (U-Boot, Linux, binutils... etc). And I used linux-wlan as the
WLAN card driver.=0D

But one more thing is I have built 2 of such systems and only tried the
normal WLAN functions (infrastructure, ad-hoc mode) but never AP mode
since the driver and my WLAN card does not support.

Here are some references:

1. WLAN card driver: linux-wlan -- http://www.linux-wlan.org/
2. Freescale MPC860 User Manual: --
http://www.freescale.com/files/netcomm/doc/ref_manual/MPC860UM.pdf

Thanks for your attention.

Best regards,
Lo Chun Chung

-----Original Message-----
From: linuxppc-embedded-bounces+cclo=3Dastri.org@ozlabs.org
[mailto:linuxppc-embedded-bounces+cclo=3Dastri.org@ozlabs.org] On Behalf
Of wei.li4@elf.mcgill.ca
Sent: Wednesday, 06 September, 2006 4:04 AM
To: linuxppc-embedded@ozlabs.org
Subject: Wireless Linux(802.11) for Embedded PowerPC


Hi All,

Where is the best access point for this topic? Did anyone work on this=0D
with MPC8xx? Thanks.

Wei
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

This message (including any attachments) is for the named addressee(s)'s=
 use only. It may contain
sensitive, confidential, private proprietary or legally privileged=
 information intended for a
specific individual and purpose, and is protected by law. If you are not=
 the intended recipient,
please immediately delete it and all copies of it from your system, destroy=
 any hard copies of it
and notify the sender. Any use, disclosure, copying, or distribution of=
 this message and/or any
attachments is strictly prohibited.
