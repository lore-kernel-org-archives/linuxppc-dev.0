Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1A957B7B72
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 11:56:21 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D64DDDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 11:56:20 +1000 (EST)
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te,ud,md}_free_tlb()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1247708177.9851.4.camel@concordia>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
	<1247708177.9851.4.camel@concordia>
Content-Type: text/plain
Date: Thu, 16 Jul 2009 11:56:05 +1000
Message-Id: <1247709365.27937.6.camel@pasglop>
Mime-Version: 1.0
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
	linuxppc-dev@ozlabs.org, Hugh Dickins <hugh@tiscali.co.uk>,
	linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-16 at 11:36 +1000, Michael Ellerman wrote:
> 
> Builds for the important architectures, powerpc, ia64, arm, sparc,
> sparc64, oh and x86:
> 
> http://kisskb.ellerman.id.au/kisskb/head/1976/
> 
> (based on your test branch 34f25476)

Note for all lurkers: the fails in there are unrelated to the patch
(mostly warnings triggering our new Werror and probably mostly fixed
upstream already).

Cheers,
Ben.
