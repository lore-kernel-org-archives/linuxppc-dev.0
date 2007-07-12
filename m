Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7930DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 22:07:06 +1000 (EST)
Message-ID: <4696199B.3040105@genesi-usa.com>
Date: Thu, 12 Jul 2007 13:07:55 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
References: <46951C1A.4080001@genesi-usa.com>
	<20070712065104.GI4375@moe.telargo.com>
In-Reply-To: <20070712065104.GI4375@moe.telargo.com>
Content-Type: text/plain; charset=UTF-8
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Domen,

You wouldn't have tried these on the Efika yet, would you?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Domen Puncer wrote:
> On 11/07/07 19:06 +0100, Matt Sealey wrote:
>> Does anyone have the definitive patchset to enable the tickless hz,
>> some kind of hrtimer and the other related improvements in the
>> PowerPC tree?
> 
> I use attached patches for tickless.
> Order in which they're applied:
> 
> PowerPC_GENERIC_CLOCKEVENTS.patch
> PowerPC_GENERIC_TIME.linux-2.6.18-rc6_timeofday-arch-ppc_C6.patch
> PowerPC_enable_HRT_and_dynticks_support.patch
> PowerPC_no_hz_fix.patch
> tickless-enable.patch
> 
> HTH
> 
> 
> 	Domen
