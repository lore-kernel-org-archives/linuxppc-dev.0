Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F4BADE79D
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:44:50 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m9DIiisk011583
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:44:45 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m9DIiiQW027651
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 13:44:44 -0500 (CDT)
Date: Mon, 13 Oct 2008 13:44:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
Message-ID: <20081013184443.GA20612@ld0162-tx32.am.freescale.net>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.64.0810132003350.9041@axis700.grange>
Cc: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 13, 2008 at 08:05:09PM +0200, Guennadi Liakhovetski wrote:
> On Mon, 13 Oct 2008, Rogério Brito wrote:
> 
> > The current defconfig for Linkstation/Kuroboxes has the "Disable Heap
> > Randomization" option enabled.
> > 
> > Since some of these machines are facing the internet, it helps to have
> > heap randomization enabled. This patch enables it.
> 
> Same as the previous patch - this is one of options, that users select 
> according to their needs. If any specific distribution enables this option 
> by default in their kernels, they can do this too, don't think this is 
> critical enough to patch the defconfig.

Just because users/distros can change it doesn't mean it's pointless to
discuss what default is sane, and make changes if the current default
isn't.

For security-related options it's usually best to default to the more
secure state, especially since the option description talks about it
being needed mainly for libc5 compatibility -- did libc5 ever even exist
for powerpc?  

The only reason it was turned on in the first place was likely the
"default y", which in turn is there to avoid breaking old x86 distros.

-Scott
