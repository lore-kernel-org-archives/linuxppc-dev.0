Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE2BBDDF14
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 07:43:45 +1000 (EST)
Subject: Re: [git pull] Please pull from powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BAF7B55C-75C2-4BCA-8686-34A843865C91@kernel.crashing.org>
References: <1216973590.11188.99.camel@pasglop>
	<BAF7B55C-75C2-4BCA-8686-34A843865C91@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 26 Jul 2008 07:43:08 +1000
Message-Id: <1217022188.11188.112.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-25 at 10:07 -0500, Kumar Gala wrote:
> On Jul 25, 2008, at 3:13 AM, Benjamin Herrenschmidt wrote:
> 
> >
> > Benjamin Herrenschmidt (1):
> >      Move update_mmu_cache() declaration from tlbflush.h to pgtable.h
> 
> I'm guessing this was pretty trivial, but please post patches to the  
> list even if you've committed them to your tree.

This was a last minute build fix I stuck in to ... fix the build :-)
Some new stuff from Christoph Lameter broke ppc32 build without that
fix.

Next time I'll also send it to the list as well.

Ben.
