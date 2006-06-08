Return-Path: <mikey@ozlabs.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: oprofile support for POWER6 
In-reply-to: <4AE0F2C6-99B7-40AF-AB28-71D51C1141A5@kernel.crashing.org> 
References: <20060607012359.D59C467B37@ozlabs.org>
	<4AE0F2C6-99B7-40AF-AB28-71D51C1141A5@kernel.crashing.org>
Date: Thu, 08 Jun 2006 14:29:01 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060608042915.C568867B1A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >  	/*
> > -	 * SIHV / SIPR bits are only implemented on POWER4+ (GQ) and above.
> > -	 * However we disable it on all POWER4 until we verify it works
> > -	 * (I was seeing some strange behaviour last time I tried).
> > -	 *
> > -	 * It has been verified to work on POWER5 so we enable it there.
> > -	 */
> 
> The patched code doesn't handle GQ at all.  Is this on purpose?  Add a
> similar comment to the CPU feature tables perhaps?

Yeah, those bits are bust on POWER4+.  We didn't touch them previously
and we still don't with this patch.

You're right, we should keep that comment. I'll update and retransmit.

Mikey
