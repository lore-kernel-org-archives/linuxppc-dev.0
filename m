Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 7630ADDDDB
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 12:48:33 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so1418073pyi.0
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 17:48:32 -0800 (PST)
Date: Fri, 21 Dec 2007 19:48:28 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 17/21] [POWERPC] Base support for 440SPe "Katmai" eval
	board
Message-ID: <20071221194828.3a6e6299@vader.jdub.homelinux.org>
In-Reply-To: <20071222112105.b24c85c5.sfr@canb.auug.org.au>
References: <20071221043938.9C15EDDFBF@ozlabs.org>
	<20071222112105.b24c85c5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 22 Dec 2007 11:21:05 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Fri, 21 Dec 2007 15:39:34 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > +++ linux-merge/arch/powerpc/platforms/44x/katmai.c	2007-12-21 14:34:33.000000000 +1100
> > +
> > +static struct of_device_id katmai_of_bus[] = {
> 
> __initdata (preferably) or const, please.

I'll fix this with a separate commit.  The same comment applies for all
the 4xx platforms already in the kernel.

josh
