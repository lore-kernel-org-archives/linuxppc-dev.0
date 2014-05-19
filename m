Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E49B914007F
 for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2014 03:48:05 +1000 (EST)
Message-ID: <1400521677.18239.16.camel@snotra.buserror.net>
Subject: Re: questions on CONFIG_PPC_ADV_DEBUG_REGS, DBCR0_BRT, and
 DBCR0_ACTIVE_EVENTS
From: Scott Wood <scottwood@freescale.com>
To: shiva7 <sivasakthi7@outlook.com>
Date: Mon, 19 May 2014 12:47:57 -0500
In-Reply-To: <1400456291193-82408.post@n7.nabble.com>
References: <5167457E.1050205@genband.com>
 <1398170592855-81732.post@n7.nabble.com>
 <1398205896.1694.252.camel@snotra.buserror.net>
 <1398206224.1694.254.camel@snotra.buserror.net>
 <1400456291193-82408.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-05-18 at 16:38 -0700, shiva7 wrote:
> Thanks Scott.
> 
> Apologize for not quoting the old email reference.

You did it again. :-)

> I assumed the old archive content always will be in the trail.

It's in the archives (as I noted), but it's a pain to search for it
versus having relevant bits quoted.

> Any idea whether the DBCR0 BRT bit actually works(??),

Do you have reason to believe that it might not?

> if I add  DBCR0 under sys_debug context call? because this code seems
> like direct porting and wondering why on first place not included under
> debug_context call. 

Again, it was probably an oversight, but the people who might know for
sure are no longer reachable.

> And also, anything special required for "server" family application code
> porting here ?? as because in server family the trace exception used to viz
> NORMAL exception proglog and uses SRR0 and SRR1 but in this ISA/embedded
> case have dedicated DEBUG_DEBUG prolog and dedicated registers DSRR0 and
> DSRR1.

IIRC the branch taken mechanism does have different semantics than the
equivalent mechanism on server.  You can find discussion of this in the
archives. :-)

-Scott
