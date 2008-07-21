Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 02ADEDDDF0
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 11:17:36 +1000 (EST)
Date: Sun, 20 Jul 2008 18:16:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: benh@kernel.crashing.org
Subject: Re: [patch] powerpc: implement pte_special for 64K pages
Message-Id: <20080720181658.02651e2f.akpm@linux-foundation.org>
In-Reply-To: <1216601875.11027.59.camel@pasglop>
References: <20080717104426.GA25083@wotan.suse.de>
	<1216601875.11027.59.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev@ozlabs.org,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Jul 2008 10:57:55 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2008-07-17 at 12:44 +0200, Nick Piggin wrote:
> > This can be folded into powerpc-implement-pte_special.patch
> > 
> > --
> > Ben has now freed up a pte bit on 64k pages. Use it for special pte bit.
> > 
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> > ---
> 
> Ack.
> 
> Andrew, will you merge this or do you want me to ?

I can do so.
