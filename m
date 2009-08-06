Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 68645B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 22:27:10 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AE891DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 22:27:09 +1000 (EST)
Subject: Re: [PATCH] powerpc/perfctr: Check oprofile_cpu_type for NULL
	before using it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1249556586.4800.79.camel@concordia>
References: <1249531356.18245.73.camel@pasglop>
	<1249556586.4800.79.camel@concordia>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 22:26:39 +1000
Message-Id: <1249561599.18245.80.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-06 at 21:03 +1000, Michael Ellerman wrote:
> 
> Typing it seven times didn't make you think "how about a helper?" :)

Copy/paste works fine :-) Seriously, I did think about it, but a couple
of cases test more than one string so a totally trivial helper wouldn't
do and I couldn't be bothered doing anything more complicated while
under influenza :-) You are welcome to do something nicer for .32.

BTW. While at it, I think we should move that stuff to a separate
subdir too.

Cheers,
Ben.
