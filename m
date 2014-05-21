Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C61851A0814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 02:08:12 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] powerpc: fix typo 'CONFIG_PMAC'
References: <1400617498.4912.66.camel@x220>
Date: Wed, 21 May 2014 18:08:04 +0200
In-Reply-To: <1400617498.4912.66.camel@x220> (Paul Bolle's message of "Tue, 20
 May 2014 22:24:58 +0200")
Message-ID: <874n0j3yjf.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Bolle <pebolle@tiscali.nl> writes:

> Commit b0d278b7d3ae ("powerpc/perf_event: Reduce latency of calling
> perf_event_do_pending") added a check for CONFIG_PMAC were a check for
> CONFIG_PPC_PMAC was clearly intended.
>
> Fixes: b0d278b7d3ae ("powerpc/perf_event: Reduce latency of calling perf_event_do_pending")
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested. Needs testing on 32 bit powermac, I guess.
>
> This typo was introduced in v2.6.36. No one noticed because very few
> people still use 32 bit powermacs?

How does that bug manifest itself?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
