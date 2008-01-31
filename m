Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id EF87BDDE03
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 05:19:35 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so193931anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 10:19:34 -0800 (PST)
Message-ID: <fa686aa40801310922n6dec35eat92f0f27998a506bd@mail.gmail.com>
Date: Thu, 31 Jan 2008 10:22:52 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [RFC] [POWERPC] bootwrapper: build multiple cuImages
In-Reply-To: <20080131160042.GA24370@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080131003347.5779.96112.stgit@trillian.secretlab.ca>
	<20080131014952.83827290071@mail95-dub.bigfish.com>
	<fa686aa40801301840k3d9a9ba2n251d2cdb9e659748@mail.gmail.com>
	<20080131160042.GA24370@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/31/08, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, Jan 30, 2008 at 07:40:28PM -0700, Grant Likely wrote:
> > mpc866ads, mpc885ads and ep88xc are oddities in that they build
> > zImages with embedded device tree blobs.
>
> What about ep8248e?  And the mpc8xxads boards use cuImage, not zImage.

Oops, those are just mistakes.  I can fix them

>
> > One option would be to add two new targets: zImage.dtb.% and
> > zImage.initrd.dtb.%, but I'm not sure if it is a good idea.
>
> I'd much prefer that over having several lines per board in the makefile.

Okay, I can change that.

Another option is to modify the wrapper to specifically look for
targets which need the dtb.  At the moment, that list includes ps3,
ep8248e, mpc885ads and ep88xc.  All four could be using a common build
target.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
