Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0E8FDDF8F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 05:45:09 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l49Jj53E006557
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 15:45:05 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l49Jj41S512162
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 15:45:04 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l49Jj3bs023775
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 15:45:03 -0400
Date: Wed, 9 May 2007 14:45:03 -0500
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Section mismatch warnings (was Re: [PATCH] early_pfn_to_nid needs
	to be __meminit)
Message-ID: <20070509194503.GZ4452@austin.ibm.com>
References: <20070510022552.4bb1a407.sfr@canb.auug.org.au>
	<20070509165115.GA23576@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070509165115.GA23576@iram.es>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 09, 2007 at 06:51:15PM +0200, Gabriel Paubert wrote:
> On Thu, May 10, 2007 at 02:25:52AM +1000, Stephen Rothwell wrote:
> > This removes a section mismatch warning in those circumstances.
> 
> Speaking of this, I just tried to compile an official (Linus' git tree) 
> kernel for my old PMac G4 and I get a lot of section mismatch warnings at 
> the end of the compilation:
> 
> WARNING: arch/powerpc/mm/built-in.o - Section mismatch: reference to .init.text:early_get_page from .text between 'pte_alloc_one_kernel' (at offset 0xf50) and 'v_mapped_by_bats'
> 
> I find these 50 or so warnings so scary that I've not yet tried 
> to boot the kernel. Note that this is a non-modular kernel.

I'm getting oodles of these on an older -mm2 tree. The kernels seem to
work fine. Yes, they should be fixed but I'm up to my proverbial eyballs
in alligators.

--linas
