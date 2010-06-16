Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 61DCBB7D81
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 17:38:17 +1000 (EST)
Date: Wed, 16 Jun 2010 09:38:05 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-ID: <20100616093805.3a8df747@wker>
In-Reply-To: <AANLkTims596hCnLgN5Po6nS1bRFxKywEDlBA4mlreciV@mail.gmail.com>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
	<20100601113801.5b0ff773@wker>
	<AANLkTims596hCnLgN5Po6nS1bRFxKywEDlBA4mlreciV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Timur,

On Fri, 4 Jun 2010 10:46:28 -0500
Timur Tabi <timur@freescale.com> wrote:

> On Tue, Jun 1, 2010 at 4:38 AM, Anatolij Gustschin <agust@denx.de> wrote:
> 
> > Could you please test these patches on MPC8610 HPCD? I think these
> > changes won't break that platform. The patches apply cleanly on
> > 2.6.35-rc1.
> 
> I'll try to get to them as soon as I can.

Any chance this could be done soon? I'd like to include the MPC5121e DIU
support in 2.6.36 since it is currently broken in mainline and the patches
provide the fix.

Thanks,
Anatolij
