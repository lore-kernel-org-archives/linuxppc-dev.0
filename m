Return-Path: <kim.phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97C90DE02B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 09:38:52 +1000 (EST)
Date: Tue, 26 May 2009 18:38:34 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [U-Boot] [PATCH 1/2] 83xx: Replace CONFIG_MPC83XX with
	CONFIG_MPC83xx
Message-Id: <20090526183834.76345105.kim.phillips@freescale.com>
In-Reply-To: <20090524201327.CB44C832E416@gemini.denx.de>
References: <82eccabef9b5f2ad7f747ee9ba966546ef366745.1243030613.git.ptyser@xes-inc.com>
	<20090524140034.568bca6d.kim.phillips@freescale.com>
	<1243192952.703.7.camel@ptyser-laptop>
	<20090524201327.CB44C832E416@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Peter Tyser <ptyser@xes-inc.com>,
	u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 24 May 2009 22:13:27 +0200
Wolfgang Denk <wd@denx.de> wrote:

> Dear Peter,
> 
> In message <1243192952.703.7.camel@ptyser-laptop> you wrote:
> >
> > > CodingStyle Ch.12 suggests that it's the other fsl arches that are in
> > > violation here, not 83XX:
> 
> Agreed...
> 
> > Either way is fine with me, as long as things are consistent.  It looked
> > like most Freescale CPUs in U-Boot as well as Linux used the lowercase
> > convention for CONFIG_<cpu type> so I thought:
> > a. Most likely someone made a conscious decision to use lowercase

I can understand it in comments and quotes, just not in constants in
the code.

> > b. It'd be much easier to change just 83xx than all other arches:)

that's not a good reason to do it this way though.

> > If others would prefer standardizing on uppercase, I can submit new
> > patches for 85xx, 5xxx, 86xx, etc.  This would be still be inconsistent
> > with Linux though, which is a bit annoying.
> 
> It seems Linux uses 8?xx with very few exceptions (CONFIG_SND_VIA82XX*
> and CONFIG_EDAC_MPC85XX), so let's do the same here.

so linux is inconsistent too.

I'm a fan of a more self-consistent CONFIG_MPC85XX_MDS over mixed-case
names like linux' CONFIG_MPC85xx_MDS.

I wonder if the linux ppc guys would accept a
s/CONFIG_MPC8?xx/CONFIG_MPC8?XX/g rename patch for linux...

Kim
