Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F1F6B1400FA
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2014 08:31:53 +1000 (EST)
Message-ID: <1398205896.1694.252.camel@snotra.buserror.net>
Subject: Re: questions on CONFIG_PPC_ADV_DEBUG_REGS, DBCR0_BRT, and
 DBCR0_ACTIVE_EVENTS
From: Scott Wood <scottwood@freescale.com>
To: shiva7 <sivasakthi7@outlook.com>
Date: Tue, 22 Apr 2014 17:31:36 -0500
In-Reply-To: <1398170592855-81732.post@n7.nabble.com>
References: <5167457E.1050205@genband.com>
 <1398170592855-81732.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Chris Friesen <chris.friesen@genband.com>, linuxppc-dev@ozlabs.org,
 Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
 Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-22 at 05:43 -0700, shiva7 wrote:
> I have the same question as like above posted by Mr. Chirs. 

I had to google the subject to find what e-mail you were talking about
-- it was posted a year ago:

http://marc.info/?l=linuxppc-embedded&m=136572252330650&w=2

Next time please quote the e-mail if you're trying to revive a thread,
and keep the original poster on CC.

I've quoted it here:

> Sorry for the bunch of emails, I'm working on some new stuff and running 
> into issues.
> 
> For CONFIG_BOOKE it appears that DBCR0_ACTIVE_EVENTS includes DBCR0_ICMP 
> but not DBCR0_BRT.  Is that just because none of the code paths 
> currently using DBCR0_ACTIVE_EVENTS need to check DBCR0_BT?

Perhaps it was just an oversight.  I've CCed Dave Kleikamp and Torez
Smith, who added DBCR0_ACTIVE_EVENTS.

> Also, in sys_debug_setcontext() why does SIG_DBG_BRANCH_TRACING return 
> -EINVAL if CONFIG_PPC_ADV_DEBUG_REGS is set?  Would it not be possible 
> to use DBCR0_BRT?

Either nobody has gotten around to implementing it, or the semantics
are different in some way (if the semantics are even defined anywhere
-- I couldn't find any documentation).

-Scott
