Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 926E3B7D12
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jun 2010 19:38:13 +1000 (EST)
Date: Tue, 1 Jun 2010 11:38:01 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-ID: <20100601113801.5b0ff773@wker>
In-Reply-To: <y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
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

On Thu, 29 Apr 2010 20:39:02 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:
> > This patch series rework DIU support patches submitted
> > previously. Comments to the previos patch series have
> > been addressed, not related changes are dropped and some
> > changes are split out to separate patches to simplify
> > review. Furthermore a patch has been added to support
> > setting display mode using EDID block in the device tree.
> 
> Have you tested these changes on an MPC8610 HPCD?  If not, do you
> think your changes will break that platform?
> 
> I have an 8610 in-house, but I'm currently working on another issue on
> that board, so I can't test these patches for you just yet.

Could you please test these patches on MPC8610 HPCD? I think these
changes won't break that platform. The patches apply cleanly on
2.6.35-rc1.

Thanks,
Anatolij
