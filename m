Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 1908EDDF21
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:03:24 +1000 (EST)
Message-ID: <4717ADE6.3020304@semihalf.com>
Date: Thu, 18 Oct 2007 21:03:02 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 3/4] [POWERPC] Add restart support for mpc52xx based
	platforms
References: <20071018184407.3584.3513.stgit@hekate.izotz.org>	
	<20071018184433.3584.77107.stgit@hekate.izotz.org>
	<fa686aa40710181153w7bb794ceve38e7802d603ad42@mail.gmail.com>
In-Reply-To: <fa686aa40710181153w7bb794ceve38e7802d603ad42@mail.gmail.com>
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

Grant Likely wrote:
> On 10/18/07, Marian Balakowicz <m8@semihalf.com> wrote:
>> Add common helper routines: mpc52xx_map_wdt() and mpc52xx_restart().
>>
>> This patch relies on Sascha Hauer's patch published in:
>> http://patchwork.ozlabs.org/linuxppc/patch?id=8910.
> 
> By 'relies', do you mean "depends on" or "was derived from"?

Initial version was derived from, and since then it slightly evolved.

m.
