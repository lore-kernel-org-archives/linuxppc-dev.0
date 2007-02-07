Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7756DDDE2C
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 11:19:06 +1100 (EST)
Message-ID: <45C91AF5.8090700@garzik.org>
Date: Tue, 06 Feb 2007 19:19:01 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
References: <45C86715.6090600@freescale.com>
In-Reply-To: <45C86715.6090600@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Li Yang wrote:
> Get rid of private immrbar_virt_to_phys() routine and
> use generic iopa().
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> drivers/net/ucc_geth.c |   29 ++++++-----------------------
> 1 files changed, 6 insertions(+), 23 deletions(-)

I'll await resend pending resolution of comments
