Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CF7BDDD08
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 04:33:03 +1100 (EST)
Subject: Re: [PATCH] BLK_DEV_IDE_CELLEB dependency fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <45F9588C.7020108@ru.mvista.com>
References: <200703150628.l2F6SPa3028035@toshiba.co.jp>
	<45F9588C.7020108@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 15 Mar 2007 18:31:56 +0100
Message-Id: <1173979916.6861.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Al Viro <viro@ftp.linux.org.uk>, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-15 at 17:30 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Akira Iguchi wrote:
> 
> > It's bool and it depends on BLK_DEV_IDE
> >  => should depend on BLK_DEV_IDE=y
> 
>     Hm, why I'm seeing module_init() in the driver? :-)
> 
> > And move it to "if BLK_DEV_IDEDMA_PCI" block because it depends on 
> > BLK_DEV_IDEDMA_PCI.
> 
>     IMHO, that driver shouldn't be in drivers/ide/ppc/ then...  Why it got 
> there (the same question about PowerMac driver)?

Not sure... some reorg changes ide-pmac.c into ppc/pmac.c or such, I
don't remember who did it tho.

Ben.
