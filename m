Return-Path: <SRS0+d4ed8532fc229d852d10+1409+infradead.org+mchehab@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A281DDEC8
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 01:02:46 +1000 (EST)
Subject: Re: How to handle patches that cross maintainers?
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4BEFAFC6-3346-4F29-B1C5-377952E3FBBF@kernel.crashing.org>
References: <4BEFAFC6-3346-4F29-B1C5-377952E3FBBF@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Jul 2007 12:01:50 -0300
Message-Id: <1183474910.3926.134.camel@gaivota>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Em Ter, 2007-07-03 às 04:01 -0500, Kumar Gala escreveu:
> Andrew,
> 
> I was hoping to get your input on how to handle patches that cross  
> maintainers.  I've got a patch that is pretty PPC specific, but  
> happens to touch some drivers as well.
> 
> Here's the diffstat to get a rough idea:
> 
> arch/powerpc/kernel/io.c                |   12 ++++++------
> arch/powerpc/mm/hash_native_64.c        |    2 +-
> arch/powerpc/mm/stab.c                  |    4 ++--
> drivers/ide/pci/scc_pata.c              |    4 ++--
> drivers/media/dvb/bt8xx/bt878.h         |    5 ++---
> drivers/serial/cpm_uart/cpm_uart_core.c |    2 +-
> include/asm-powerpc/system.h            |    2 +-
> 7 files changed, 15 insertions(+), 16 deletions(-)
> 
> Now, I've had this issue before w/o any good sense on how to handle it.

The better is to copy all of us and wait for some time to allow each
maintainer to ack or comment the changeset, if needed.

Please c/c me for any changes on /drivers/media stuff.

Cheers,
Mauro
