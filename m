Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	by ozlabs.org (Postfix) with ESMTP id 1A9D1DE032
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 17:07:49 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: u-boot@lists.denx.de
Subject: Re: [U-Boot] [PATCH 1/2] 83xx: Replace CONFIG_MPC83XX with
	CONFIG_MPC83xx
Date: Wed, 27 May 2009 09:08:05 +0200
References: <82eccabef9b5f2ad7f747ee9ba966546ef366745.1243030613.git.ptyser@xes-inc.com>
	<20090524201327.CB44C832E416@gemini.denx.de>
	<20090526183834.76345105.kim.phillips@freescale.com>
In-Reply-To: <20090526183834.76345105.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200905270908.05777.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Peter Tyser <ptyser@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 27 May 2009 01:38:34 Kim Phillips wrote:
> > > If others would prefer standardizing on uppercase, I can submit new
> > > patches for 85xx, 5xxx, 86xx, etc.  This would be still be inconsistent
> > > with Linux though, which is a bit annoying.
> >
> > It seems Linux uses 8?xx with very few exceptions (CONFIG_SND_VIA82XX*
> > and CONFIG_EDAC_MPC85XX), so let's do the same here.
>
> so linux is inconsistent too.
>
> I'm a fan of a more self-consistent CONFIG_MPC85XX_MDS over mixed-case
> names like linux' CONFIG_MPC85xx_MDS.
>
> I wonder if the linux ppc guys would accept a
> s/CONFIG_MPC8?xx/CONFIG_MPC8?XX/g rename patch for linux...

Just to add my 0.02$ as well, I prefer the lower case version CONFIG_8?xx. 
It's used for 4xx this way as well in Linux and U-Boot. Perhaps I'm just used 
to reading it this way...

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
