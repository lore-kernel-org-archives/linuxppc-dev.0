Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE001.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 469DADE303
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 08:50:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: Kconfig debug help
Date: Tue, 5 Aug 2008 16:50:41 -0600
In-Reply-To: <1217976528.2328.54.camel@localhost.localdomain>
References: <20080805213759.96642158806D@mail101-wa4.bigfish.com>
	<1217976528.2328.54.camel@localhost.localdomain>
From: John Linn <John.Linn@xilinx.com>
To: <jwboyer@linux.vnet.ibm.com>
Message-ID: <20080805225045.436FA68005D@mail2-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Josh, I just came to the conclusion it was busted somehow in the
mainline after repeating it there.

-- John

> -----Original Message-----
> From: Josh Boyer [mailto:jwboyer@gmail.com] On Behalf Of Josh Boyer
> Sent: Tuesday, August 05, 2008 4:49 PM
> To: John Linn
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: Kconfig debug help
> =

> On Tue, 2008-08-05 at 15:37 -0600, John Linn wrote:
> > I'm trying to debug some Kconfig problems and am looking for a way
to
> > get more debug output.
> >
> >
> >
> > I have used KBUILD_VERBOSE=3D1 on the command line and it didn't help
> > much.
> >
> >
> >
> > I'm seeing an issue with creating a new defconfig file for a board.
I
> > get the .config created, then copy it to a defconfig, and then it
> > doesn't do anything when I run make with the defconfig file.
> =

> Yeah, I hit that myself this weekend.  It's a bug in the Kconfig area.
> It's 1/2 fixed in the latest Linus and powerpc trees.
> =

> josh
> =

> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
