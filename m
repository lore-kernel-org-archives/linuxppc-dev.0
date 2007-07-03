Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A090CDDE45
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 19:38:26 +1000 (EST)
Date: Tue, 3 Jul 2007 02:38:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to handle patches that cross maintainers?
Message-Id: <20070703023805.f174b5b8.akpm@linux-foundation.org>
In-Reply-To: <4BEFAFC6-3346-4F29-B1C5-377952E3FBBF@kernel.crashing.org>
References: <4BEFAFC6-3346-4F29-B1C5-377952E3FBBF@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: list <linuxppc-dev@ozlabs.org>, linuxppc-dev,
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

On Tue, 3 Jul 2007 04:01:20 -0500 Kumar Gala <galak@kernel.crashing.org> wrote:

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
> 
> Suggestions?
> 

Well, assuming that all the changes are interdependent and cannot be split
up: send it to the relevant maintainers, gather the acks and merge it up
yourself.
