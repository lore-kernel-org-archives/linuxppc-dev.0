Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE002.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id C1383DE532
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:26:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: Please pull linux-2.6-virtex.git
Date: Mon, 7 Jul 2008 08:26:50 -0600
In-Reply-To: <20080707141332.6CDD313E8050@mail111-sin.bigfish.com>
References: <20080704172240.GE17062@secretlab.ca><1215433036.20774.39.camel@weaponx>
	<20080707141332.6CDD313E8050@mail111-sin.bigfish.com>
From: John Linn <John.Linn@xilinx.com>
To: "John Linn" <John.Linn@xilinx.com>, "Josh Boyer" <jwboyer@gmail.com>,
	<grant.likely@secretlab.ca>
Message-ID: <20080707142652.43C32110807E@mail204-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Where should I be looking to understand what's needed for dts-v1 format?

I did a quick review of Doc*/powerpc/booting-wihtout-of.txt and didn't
see it, but maybe I overlooked it.

Thanks,
John =


> -----Original Message-----
> From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of John Linn
> Sent: Monday, July 07, 2008 8:14 AM
> To: Josh Boyer; grant.likely@secretlab.ca
> Cc: linuxppc-dev@ozlabs.org
> Subject: RE: Please pull linux-2.6-virtex.git
> =

> I'll look at the dts file and converting it to v1 format, hopefully
> soon.
> =

> Thanks,
> John
> =

> > -----Original Message-----
> > From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
> [mailto:linuxppc-dev-
> > bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Josh Boyer
> > Sent: Monday, July 07, 2008 6:17 AM
> > To: grant.likely@secretlab.ca
> > Cc: linuxppc-dev@ozlabs.org
> > Subject: Re: Please pull linux-2.6-virtex.git
> >
> > On Fri, 2008-07-04 at 11:22 -0600, Grant Likely wrote:
> > > Hi Josh,
> > >
> > > Here are the bulk of the Xilinx 440 support patches.  Please pull
> > > into your next branch.
> > >
> > > Thanks,
> > > g.
> > >
> > > The following changes since commit
> f3e909c2750eb20536bacacc867dc9047b70546a:
> > >   Michael Neuling (1):
> > >         powerpc: Update for VSX core file and ptrace
> > >
> > > are available in the git repository at:
> > >
> > >   git://git.secretlab.ca/git/linux-2.6-virtex virtex-for-2.6.27
> > >
> >
> > <snip>
> >
> > > John Linn (5):
> > >       powerpc/virtex: add dts file for ML507 reference design
> >
> > This one still isn't a dts-v1 file.  Any chance of that getting
fixed
> in
> > the next day or two?
> >
> > josh
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> =

> =

> This email and any attachments are intended for the sole use of the
named recipient(s) and contain(s)
> confidential information that may be proprietary, privileged or
copyrighted under applicable law. If
> you are not the intended recipient, do not read, copy, or forward this
email message or any
> attachments. Delete this email message and any attachments
immediately.
> =

> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
