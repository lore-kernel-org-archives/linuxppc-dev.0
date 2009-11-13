Return-Path: <John.Linn@xilinx.com>
Received: from mail137-va3-R.bigfish.com (mail-va3.bigfish.com
	[216.32.180.113])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9BCB8B7B68
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 06:59:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH v3 0/4] xilinx_spi: Split into platform and of driver,
	support new IP, platform independence.
Date: Fri, 13 Nov 2009 12:59:40 -0700
In-Reply-To: <fa686aa40911131029uddb497ah7907ccd9dc23c6e3@mail.gmail.com>
References: <4AFD50F0.6050805@mocean-labs.com>
	<fa686aa40911131029uddb497ah7907ccd9dc23c6e3@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	=?iso-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Message-ID: <74ee2358-38c2-472b-9c53-2fb7ad51da60@VA3EHSMHS023.ehs.local>
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gra=
nt Likely
> Sent: Friday, November 13, 2009 11:30 AM
> To: Richard R=F6jfors
> Cc: spi-devel-general@lists.sourceforge.net; linuxppc-dev@ozlabs.org; And=
rew Morton;
> dbrownell@users.sourceforge.net; John Linn
> Subject: Re: [PATCH v3 0/4] xilinx_spi: Split into platform and of driver=
, support new IP, platform
> independence.
> =

> On Fri, Nov 13, 2009 at 5:28 AM, Richard R=F6jfors
> <richard.rojfors@mocean-labs.com> wrote:
> > Hi,
> >
> > To follow is a series of patches against the xilinx_spi driver.
> >
> > The patchset is against 2.6.32-rc6
> >
> > The patchset addresses several problems in the current driver:
> > * It's PPC only (OF and uses PPC specific memory operations)
> > * Only supporting big endian writes
> > * Supports only 8bit SPI, support for DS570 (also 16 or 32 bit) is adde=
d.
> > * A platform driver is introduced for non OF capable architectures.
> >
> > These patches were posted as one big patch up to 4 iterations, not spli=
tted into 4.
> >
> > This version, 3, is updated after review from Grant Likely and John Lin=
n
> >
> > John Linn has also tested the code on PPC, I have only tested on X86.
> =

> Applied to my 'test' branch on git.secretlab.ca.  There was a conflict
> on patch 3/4 with a previous bugfix from John Linn.  Please check that
> I've fixed it up correctly.

I think I reverted that change as Richard's fixes it I believe.

> =

> Cheers,
> g.
> =

> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
