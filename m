Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (sg2ehsobe005.messaging.microsoft.com
	[207.46.51.79]) by ozlabs.org (Postfix) with ESMTP id B5AFCB6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 04:43:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Bug in drivers/serial/of_serial.c?
Date: Thu, 19 Nov 2009 09:42:41 -0800
In-Reply-To: <200911191833.08254.arnd@arndb.de>
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com><8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com><c2bc536b-3765-4ead-b942-88bb25253ad3@VA3EHSMHS013.ehs.local>
	<200911191833.08254.arnd@arndb.de>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Message-ID: <a1cde516-ea22-4411-bae1-74878f6bee43@SG2EHSMHS002.ehs.local>
Cc: John Linn <linnj@xilinx.com>, Alon Ziv <alonz@discretix.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Arnd
Bergmann
> Sent: Thursday, November 19, 2009 9:33 AM
> To: Stephen Neuendorffer
> Cc: John Linn; Alon Ziv; linuxppc-dev@lists.ozlabs.org
> Subject: Re: Bug in drivers/serial/of_serial.c?
> =

> On Thursday 19 November 2009, Stephen Neuendorffer wrote:
> > If the problem is in the device trees that are being generated, we
> > should fix the issue there.
> > We've been trying to avoid putting the fully specified IP versions
in
> > the kernel like this, since
> > the IP changes so often.
> =

> No, the problem that Alon has is that the firmware currently has no
> way whatsoever to give a correct device tree, because of-serial.c
> does not even know about ns16550a.
> =

> The patch adds both a special-case for the specific uart he
> is using so that one is grandfathered in and a new compatible
> value so future boards can specify both ns16550a and ns16550.

That's true...  The 16550a line still needs to get added, but not the
xlnx-
specific line.

Steve


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
