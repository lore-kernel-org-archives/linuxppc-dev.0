Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 43402DE698
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 06:27:50 +1100 (EST)
Date: Tue, 6 Jan 2009 22:27:47 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Message-ID: <20090106192747.GA3056@oksana.dev.rtsoft.ru>
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<20081231171017.6FCF585AD247@gemini.denx.de>
	<B64DF110-E26A-4229-8384-E7933732BC01@kernel.crashing.org>
	<20090105174645.GA23766@ld0162-tx32.am.freescale.net>
	<20090105180122.GA12237@oksana.dev.rtsoft.ru>
	<c384c5ea0901061053r21fbc853y3b28ae3c8e3a0e6f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <c384c5ea0901061053r21fbc853y3b28ae3c8e3a0e6f@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 06, 2009 at 07:53:57PM +0100, Leon Woestenberg wrote:
> Hello Anton,
> 
> On Mon, Jan 5, 2009 at 7:01 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > On Mon, Jan 05, 2009 at 11:46:45AM -0600, Scott Wood wrote:
> >>
> >> Why?  Unless the BSP u-boots do something insane, I think we should try
> >> to have the upstream kernel boot on the u-boot that comes on the board
> >> (it's not nice to require users to reflash unnecessarily).
> >
> > Just in case, the latest version of this patch set is compatible with
> > the FSL u-boots.
> >
> 
> Up to now, I was testing PCIe with this combo:
> - U-Boot 1.3.0-rc2 (Nov 19 2007 - 16:37:36) MPC83XX, was on the board
> - dtc 1.1.0
> - Linux 2.6.24.3 w/ Freescale patches from http://www.bitshrine.org/gpp/
> 
> 
> That u-boot (i.e. on the mpc8315e-rdb board) had PCIe initialization.
> 
> Is u-boot PCIe initialization required for this kernel patch to work?

Yup.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
