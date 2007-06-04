Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/21] This is my pending series for 2.6.23
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
References: <1180934134.603289.870346178920.qpush@grosgo>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 17:00:05 +1000
Message-Id: <1180940405.31677.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 14:49 +1000, Benjamin Herrenschmidt wrote: 
> It contains 
> 
>  - My PCI IO allocation rework (the first patch changes generic code
>    and is in -mm already)
> 
>  - spufs single step & capabilities support
> 
>  - my cleanup/merge of the ptrace code
> 
>  - patches from Christoph Hellwig and myself that fix and merge things
>    in the signal handling code
> 
> I'm still working on saving the top 32 bits of registers on 64 bits
> for signals, so that's not included here.

And one of the signal changes is causing init to segv on my laptop,
which I'm quite happy to blame on my signal frame allocation change.
(Well, at least with the serie applied up to Christoph 3rd patch, it
still boots). I'll debug that and post an updated patch.

Ben.
