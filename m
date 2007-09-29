Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6221DDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 15:18:37 +1000 (EST)
Message-ID: <46FDE028.8080501@pobox.com>
Date: Sat, 29 Sep 2007 01:18:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/9] fs_enet: Don't share the interrupt.
References: <20070920220118.GC28784@loki.buserror.net>
In-Reply-To: <20070920220118.GC28784@loki.buserror.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> This driver can't handle an interrupt immediately after request_irq

You MUST assume that you will receive an interrupt immediately after 
request_irq().  If fs_enet cannot handle that, then that is what wants 
fixing.

Please send along a fix for this, rather than band-aiding the problem.
