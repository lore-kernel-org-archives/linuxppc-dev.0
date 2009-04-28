Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 670D3DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 15:00:56 +1000 (EST)
Date: Tue, 28 Apr 2009 14:26:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: removing get_immrbase()??
Message-ID: <20090428042606.GF11265@yookeroo.seuss>
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<fa686aa40904230653j6855f8bai5248b250eb3ef515@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa686aa40904230653j6855f8bai5248b250eb3ef515@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 07:53:11AM -0600, Grant Likely wrote:
> On Wed, Apr 22, 2009 at 3:31 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > On Apr 22, 2009, at 3:16 PM, Timur Tabi wrote:
> >
> >> Scott Wood wrote:
> >>>
> >>> Timur Tabi wrote:
> >>>>>
> >>>>>      these two are related and seem like we could look for "fsl,cpm2"
> >>>>
> >>>> That's okay, as long as you don't break compatibility with older
> >>>> device trees that don't have that property, unless you can demonstrate
> >>>> that these trees would never work with the current kernel anyway.
> >>>
> >>> All CPM2 device trees should have fsl,cpm2 listed in the compatible of
> >>> the CPM node.
> >>
> >> Yes, but did they always have that compatible field?  I'm concerned
> >> about situations where someone updates his kernel but not his device
> >> tree.  This is a scenerio that we always need to try to support.
> >
> > I disagree.  If you update your kernel you should update your device tree
> > (thus we have .dts in the kernel tree and not somewhere else).
> 
> Not always possible.  The device tree may be 'softer' than firmware,
> and easier to update, but it is still firmer than the kernel.  That
> is

Again, this is not inherent, it's a platform design choice.  It's this
way for modern u-boot, but not for all platforms.

> why so much effort has been spent to not break compatibility with
> older device trees.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
