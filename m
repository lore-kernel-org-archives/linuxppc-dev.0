Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 33A1FDE0C0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 08:34:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: arch/powerpc, Xilinx, and mainline kernel support
Date: Fri, 16 May 2008 15:34:20 -0700
In-reply-to: <fa686aa40805161526ie184ae6m29a3fc78d6676720@mail.gmail.com>
References: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C0B@XMBIL132.northgrum.com>
	<fa686aa40805161526ie184ae6m29a3fc78d6676720@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
Message-Id: <20080516223422.C02A26B006F@mail34-dub.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Grant
Likely
> Sent: Friday, May 16, 2008 3:27 PM
> To: Koss, Mike (Mission Systems)
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: arch/powerpc, Xilinx, and mainline kernel support
> =

> On Fri, May 16, 2008 at 4:06 PM, Koss, Mike (Mission Systems)
> <mike.koss@ngc.com> wrote:
> > Is there any reason why the mainline 2.6.25.3 (and from what I could
see .4)
> > is missing the files to build for the Xilinx Virtex platform?
> >
> > Or in other words, I tried to build from 2.6.25.3 for the Xilinx
Virtex
> > under arch/powerpc (because arch/ppc actually crashes when once apps
start
> > to run) and it failed when trying to actually create the zImage. I
hopped
> > over to Xilinx's git server and noticed a bunch of missing entries
in the
> > boot/Makefile and source code to actually support the complete image
build
> > for a Xilinx Virtex PPC405.
> >
> > When is the Xilinx Virtex support going to be mainline official? I
need to
> > be able to grab a stable kernel and work from there rather than
using the
> > latest -rc that Xilinx is hosting on their git server.
> =

> Working on it.  Biggest problem is getting the device drivers in
> shape.  However, other than Ethernet support, current arch/powerpc
> (head of Linus' tree, not 2.6.25) should work for building virtex
> kernels.

Mike,

What is your objection to using what is in the git tree, because it is
based on 24-rc8 and not 25, or something more fundamental?

Steve


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
