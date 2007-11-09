Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 334F2DDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 01:43:52 +1100 (EST)
Message-ID: <4734721A.6030603@semihalf.com>
Date: Fri, 09 Nov 2007 15:43:38 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
References: <fa686aa40711061304k4779d01cu7fd1b17d1d34e5a2@mail.gmail.com>	
	<20071106222224.D67BA2479C@gemini.denx.de>
	<fa686aa40711061525y79f9f99eneda32b09a77ddcd5@mail.gmail.com>
In-Reply-To: <fa686aa40711061525y79f9f99eneda32b09a77ddcd5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Grant,

Grant Likely wrote:
> On 11/6/07, Wolfgang Denk <wd@denx.de> wrote:
>>
>> in message <fa686aa40711061304k4779d01cu7fd1b17d1d34e5a2@mail.gmail.com> you wrote:
>>> In other words; make the assumption that it is easier to change the
>>> kernel than it is to change the device tree.
>> Are you serious about this?
>>
>> Reading this from someone with your experience with device trees if
>> feeding my worst fears...
> 
> I think I better clarify.
> 
> Once a device tree is written and shipped on a deployed board, it may
> never change again.  Or, the kernel version may be updated more
> frequently than the device tree.
> 
> Say, for example, that in kernel 2.6.25 tqm5200 and cm5200 are both
> handled by the same platform code.  And lets say that in 2.6.26 we
> decide that they really need to have separate platform code (perhaps
> due to a firmware bug that needs to be worked around on one board).
> In this case, "mpc5200-simple-platform" has suddenly become useless.
> Or, does mpc5200-simple-platform now describe the cm5200 or the
> tqm5200?  (an assumption which cannot be made due to deployed boards
> of both types claiming "mpc5200-simple-platform").
> 
> Trying to claim "compatible" at the board level is far more difficult
> than claiming it at the device level.
> 
> Segher suggested on IRC: "for boards it is pretty much useless most of
> the time, i think -- use "model" instead"

I can imagine that we may get into various trouble (or at least the
situation is less flexible) if we are unable to update .dts file along
with the kernel image on a deployed board. If so, then in fact there
is little sens in using "mpc5200-simple-platform" compatible.

But how serious is that, does such situation frequently happen in
field? If we are able to update kernel image than what prevents .dts
file update?

Cheers,
m.
