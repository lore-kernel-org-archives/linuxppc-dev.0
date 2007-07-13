Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id DD63CDDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 18:49:39 +1000 (EST)
Date: Fri, 13 Jul 2007 10:49:37 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
Message-ID: <20070713084936.GC11476@nd47.coderock.org>
References: <46951C1A.4080001@genesi-usa.com>
	<20070712065104.GI4375@moe.telargo.com>
	<4696369A.2010200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4696369A.2010200@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/07/07 18:11 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Domen Puncer wrote:
> 
> >>Does anyone have the definitive patchset to enable the tickless hz,
> >>some kind of hrtimer and the other related improvements in the
> >>PowerPC tree?
> 
> >I use attached patches for tickless.
> >Order in which they're applied:
> 
> >PowerPC_GENERIC_CLOCKEVENTS.patch
> 
>    That's my patch which used to have both description and signoff that I'm 
> not seeing in the attached version...

Err, yes, sorry, I don't remember anymore where I picked them,
but I'm pretty sure I didn't go delete description and signoff
by hand.

> 
> >PowerPC_GENERIC_TIME.linux-2.6.18-rc6_timeofday-arch-ppc_C6.patch
> 
>    This one should come first of all, I'd say...
>    Note that it breaks TOD vsyscalls, so you need my patch that removes 
> support for those for the time being (i.e. until Tony hopefully fixes this 
> :-).  Also, there was a patch implementing read_persistent_clock() and 
> getting rid of the code setting xtime in time_init().  Attaching them 
> both...
> 
> >PowerPC_enable_HRT_and_dynticks_support.patch
> 
>    Again looks like my patch with description/signoff missing for whatever
> reason...
> 
> >PowerPC_no_hz_fix.patch
> 
>    This has nothing to do with CONFIG_NO_HZ per se -- it fixes the 
> compilation error introduced by John's patch.
> 
> >tickless-enable.patch
> 
>    That one doesn't look quite right...

That's because I made it ;-)

It did the trick of enabling tickless though.


	Domen
