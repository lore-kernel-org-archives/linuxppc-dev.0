Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 99CCEDDF74
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 04:29:01 +1100 (EST)
Message-ID: <45E9B04F.2080601@ru.mvista.com>
Date: Sat, 03 Mar 2007 20:28:47 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2.6.21-rc2] pmac ide: fix pmac_ide_dma_host_on()
	declaration
References: <200703031324.l23DOVjO003638@harpo.it.uu.se>
In-Reply-To: <200703031324.l23DOVjO003638@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, bzolnier@gmail.com, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Mikael Pettersson wrote:
> Building 2.6.21-rc2 on a PowerMac, I get:
> 
> drivers/ide/ppc/pmac.c: In function 'pmac_ide_setup_dma':
> drivers/ide/ppc/pmac.c:2042: warning: assignment from incompatible pointer type
> drivers/ide/ppc/pmac.c: In function 'pmac_ide_dma_host_on':
> drivers/ide/ppc/pmac.c:1988: warning: control reaches end of non-void function

    This fix is already in the pata-2.6 and -mm trees and has just been pushed 
to Linus:

http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/ide-fix-pmac-breakage.patch

MBR, Sergei
