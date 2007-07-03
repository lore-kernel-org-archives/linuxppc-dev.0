Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D026DDEC8
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 19:01:38 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4BEFAFC6-3346-4F29-B1C5-377952E3FBBF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: How to handle patches that cross maintainers?
Date: Tue, 3 Jul 2007 04:01:20 -0500
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
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

Andrew,

I was hoping to get your input on how to handle patches that cross  
maintainers.  I've got a patch that is pretty PPC specific, but  
happens to touch some drivers as well.

Here's the diffstat to get a rough idea:

arch/powerpc/kernel/io.c                |   12 ++++++------
arch/powerpc/mm/hash_native_64.c        |    2 +-
arch/powerpc/mm/stab.c                  |    4 ++--
drivers/ide/pci/scc_pata.c              |    4 ++--
drivers/media/dvb/bt8xx/bt878.h         |    5 ++---
drivers/serial/cpm_uart/cpm_uart_core.c |    2 +-
include/asm-powerpc/system.h            |    2 +-
7 files changed, 15 insertions(+), 16 deletions(-)

Now, I've had this issue before w/o any good sense on how to handle it.

Suggestions?

- k
