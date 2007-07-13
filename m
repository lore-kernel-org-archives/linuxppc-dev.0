Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 75F12DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 18:59:16 +1000 (EST)
Date: Fri, 13 Jul 2007 10:41:42 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
Message-ID: <20070713084142.GB11476@nd47.coderock.org>
References: <46951C1A.4080001@genesi-usa.com>
	<20070712065104.GI4375@moe.telargo.com>
	<4696199B.3040105@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4696199B.3040105@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/07/07 13:07 +0100, Matt Sealey wrote:
> Domen,
> 
> You wouldn't have tried these on the Efika yet, would you?

Not yet, but they worked on a mpc5200b based board (lite5200b).


	Domen

> 
> -- 
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
> 
> Domen Puncer wrote:
> > On 11/07/07 19:06 +0100, Matt Sealey wrote:
> >> Does anyone have the definitive patchset to enable the tickless hz,
> >> some kind of hrtimer and the other related improvements in the
> >> PowerPC tree?
> > 
> > I use attached patches for tickless.
> > Order in which they're applied:
> > 
> > PowerPC_GENERIC_CLOCKEVENTS.patch
> > PowerPC_GENERIC_TIME.linux-2.6.18-rc6_timeofday-arch-ppc_C6.patch
> > PowerPC_enable_HRT_and_dynticks_support.patch
> > PowerPC_no_hz_fix.patch
> > tickless-enable.patch
> > 
> > HTH
> > 
> > 
> > 	Domen
