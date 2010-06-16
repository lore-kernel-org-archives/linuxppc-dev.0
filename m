Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9C2471007D4
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 06:00:12 +1000 (EST)
Date: Wed, 16 Jun 2010 22:00:08 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-ID: <20100616220008.459dbc0b@wker>
In-Reply-To: <4C18FB3F.4020705@freescale.com>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
	<20100601113801.5b0ff773@wker>
	<AANLkTims596hCnLgN5Po6nS1bRFxKywEDlBA4mlreciV@mail.gmail.com>
	<20100616093805.3a8df747@wker> <4C18F0E4.90309@freescale.com>
	<20100616174714.74a2e110@mw.dip.t-dialin.net>
	<4C18FB3F.4020705@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 16 Jun 2010 11:26:39 -0500
Timur Tabi <timur@freescale.com> wrote:

> Anatolij Gustschin wrote:
> > On Wed, 16 Jun 2010 10:42:28 -0500
> > Timur Tabi <timur@freescale.com> wrote:
> > 
> >> Anatolij Gustschin wrote:
> >>
> >>> Any chance this could be done soon? I'd like to include the
> >>> MPC5121e DIU support in 2.6.36 since it is currently broken in
> >>> mainline and the patches provide the fix.
> >>
> >> Ok, I'll try it today.
> > 
> > Thanks!
> 
> I tried to build this, but it wouldn't compile, and then I realized I also
> need the 11 patches of the set "Update support for MPC512x".  Unfortunately,
> I don't have this set in my inbox.

Please use Linus' tree, v2.6.35-rc3. The 5 patches from this series
apply cleanly on top of it and 86xx/mpc8610_hpcd_defconfig builds
here. I've tested them on mpc5121e based board but I don't have
MPC8610 HPCD and can't test on it.

> Can you email me, perhaps in one tarball, all of the patches I need?

I've send you these 5 patches, same patches have been posted to the list.

Thanks four your help,
Anatolij
