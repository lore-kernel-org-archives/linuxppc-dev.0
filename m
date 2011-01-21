Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 690DDB711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 21:00:14 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix some 6xx/7xxx CPU setup functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@redhat.com>
In-Reply-To: <m31v4660zb.fsf@redhat.com>
References: <1295591723.2148.281.camel__36384.4125684865$1295591768$gmane$org@pasglop>
	<m31v4660zb.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jan 2011 21:00:07 +1100
Message-ID: <1295604007.2148.294.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-01-21 at 10:48 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > In absence of good testing I would appreciate a close inspection of the patch
> > by different pairs of eyes :-)
> 
> Looks good to me.  That broke apparently in 400d221 ("ppc32: make
> cur_cpu_spec a single pointer instead of an array"), which changed the
> calling convention in call_setup_cpu.

Nice, >5 years ago and it's not even my fault :-) Thanks for the
review !

Cheers,
Ben.
