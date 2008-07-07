Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE003.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 753FBDDFF1
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 04:27:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] [V3] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Mon, 7 Jul 2008 12:27:09 -0600
In-Reply-To: <20080707141843.ZZRA012@mailhub.coreip.homeip.net>
References: <20080707153850.4C83B128005C@mail53-wa4.bigfish.com>
	<20080707141843.ZZRA012@mailhub.coreip.homeip.net>
From: John Linn <John.Linn@xilinx.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Message-ID: <20080707182711.7F7E012D0061@mail133-dub.bigfish.com>
Cc: Sadanand Mutyala <sadanan@xilinx.com>, linux-input@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Dmitry, appreciate the help.

Powerpc dependencies in the Kconfig sound right.  Sorry for not thinking
that thru well across all architectures. =


Do you want me to spin the patch again?

-- John

> -----Original Message-----
> From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Dmitry Torokhov
> Sent: Monday, July 07, 2008 12:20 PM
> To: John Linn
> Cc: Sadanand Mutyala; linuxppc-dev@ozlabs.org;
linux-input@vger.kernel.org
> Subject: Re: [PATCH] [V3] powerpc: Xilinx: PS2: Added new XPS PS2
driver
> =

> On Mon, Jul 07, 2008 at 08:38:45AM -0700, John Linn wrote:
> > Added a new driver for Xilinx XPS PS2 IP. This driver is
> > a flat driver to better match the Linux driver pattern.
> >
> > Signed-off-by: Sadanand <sadanan@xilinx.com>
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> =

> Looks good and I am ready to apply with the exception that compile
> errors out when i try to build on x86 (asm/prom.h is missing). Do we
> need some Kconfig dependencies added?
> =

> --
> Dmitry
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
