Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews03.kpnxchange.com (cpsmtpb-ews03.kpnxchange.com
 [213.75.39.6])
 by lists.ozlabs.org (Postfix) with ESMTP id E65F21A058E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 17:10:25 +1000 (EST)
Message-ID: <1400742620.21254.22.camel@x220>
Subject: Re: [PATCH] powerpc: fix typo 'CONFIG_PMAC'
From: Paul Bolle <pebolle@tiscali.nl>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Thu, 22 May 2014 09:10:20 +0200
In-Reply-To: <874n0j3yjf.fsf@igel.home>
References: <1400617498.4912.66.camel@x220> <874n0j3yjf.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

Andreas,

On Wed, 2014-05-21 at 18:08 +0200, Andreas Schwab wrote:
> Paul Bolle <pebolle@tiscali.nl> writes:
> 
> > Commit b0d278b7d3ae ("powerpc/perf_event: Reduce latency of calling
> > perf_event_do_pending") added a check for CONFIG_PMAC were a check for
> > CONFIG_PPC_PMAC was clearly intended.
> >
> > Fixes: b0d278b7d3ae ("powerpc/perf_event: Reduce latency of calling perf_event_do_pending")
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > Untested. Needs testing on 32 bit powermac, I guess.
> >
> > This typo was introduced in v2.6.36. No one noticed because very few
> > people still use 32 bit powermacs?
> 
> How does that bug manifest itself?

Do you want to know how to test this patch on a 32 bit powermac? Ie, see
if it has any effect, and whether that effect improves things or make
things worse.

I have no clue how to do that, sorry. Perhaps someone else has.


Paul Bolle
