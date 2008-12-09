Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE005.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 9B259DDED9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Dec 2008 10:09:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: XUPV2P update to kernel 2.6 fails
Date: Tue, 9 Dec 2008 16:09:07 -0700
In-Reply-To: <493ADC3B.2040505@ee.ethz.ch>
References: <493ADC3B.2040505@ee.ethz.ch>
From: John Linn <John.Linn@xilinx.com>
To: <jamuelle@ee.ethz.ch>, "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Message-ID: <20081209230909.832FA928076@mail163-va3.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You should visit http://xilinx.wikidot.com as there's more information ther=
e.

In general, this board is not directly supported, but is very similar to ML=
405, a board with a Virtex 4 and a 405 processor.

Thanks,
John

> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org [mailto=
:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Jan M=FCller
> Sent: Saturday, December 06, 2008 1:11 PM
> To: linuxppc-embedded
> Subject: XUPV2P update to kernel 2.6 fails
> =

> Hi all,
> =

> I was wondering if anyone got the XUPV2P board successfully up and
> running with a recent 2.6 kernel?
> =

> I didn't succeed. I tried the newest kernel from xilinx git (2.6.27) and
> also an older one, 2.6.22 (also from xilinx git). For the newer I used
> the "device-tree" as bsp. For the 2.6.22 I just copied over the
> xparameters_ml300.h file.
> =

> In both cases no output at all was observable at the uart. Not even a
> single sign from the uart at any time...
> =

> Strange is, the same download.bit file is working with a 2.4 kernel.
> Could it be a kernel .config issue?
> =

> But can this really be a software/kernel issue? For the 2.4 kernel there
> was an output from the "bootloader"  (some addresses and the
> "Loading..." information) even for wrong configured kernels...
> =

> On this list I was reading something about setting the uart clockfreq
> correctly in the .dts (it was not set at all, I have to stick with EDK
> 9.1). But this didn't help for me.
> 
> To boot the FPGA I have to use an ace file on a cf-disc. For this I use
> the download.bit file together with the simpleImage.virtex405-XUPV2P.elf
> (on 2.6.27) or zImage (on 2.6.22)...
> =

> Any suggestions on this? Thanks a lot!
> =

> Regards,
> Jan
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
