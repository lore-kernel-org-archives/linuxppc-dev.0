Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE005.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 64CD0DE502
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Aug 2008 01:00:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: Board is not booting - Please Help me
Date: Fri, 1 Aug 2008 09:00:14 -0600
In-Reply-To: <20080801023412.GA32426@secretlab.ca>
References: <cf9b3c760807300044y4625ca2am60367defaa98d49b@mail.gmail.com>
	<20080801023412.GA32426@secretlab.ca>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Naresh Bhat" <nareshgbhat@gmail.com>
Message-ID: <20080801150018.280251AC8066@mail216-va3.bigfish.com>
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

Hi Grant,

John Bonesio is working with Montavista to get these problems solved.

Thanks,
John

> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Grant Likely
> Sent: Thursday, July 31, 2008 8:34 PM
> To: Naresh Bhat
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Board is not booting - Please Help me
> =

> On Wed, Jul 30, 2008 at 01:14:52PM +0530, Naresh Bhat wrote:
> > Hi Guys
> > I have ML507 board.  By using "ml507_bsb_design_ppc440.zip"
> > I have created the "Base System Builder" project and also
> >
> > I am able to create the following files sucessfully.
> >
> > 1. My own "DTS" file (attached with the mail)
> > 2. My own "download.bit" file
> > 3. My own ACE file. (Used the Montavista Pro 5.0 kernel., Kernel is
compiled
> > with ARCH=3Dpowerpc, CROSS_COMPILE=3Dppc_440-, used the ml507_defconfig=
)
> =

> Unfortunately, I'm not able to help much with the Montavista kernel
> since I don't know anything about which version it is based on.  Have
> you tried using the current mainline kernel source or Xilinx's
published
> git repo?
> =

> To use mainline, try copying your .dts file to
> arch/powerpc/boot/dts/virtex440-myml507.dts and then build the kernel
> with 'make simpleImage.virtex440-myml507'
> =

> g.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
