Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6439EDDDF8
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 15:21:11 +1000 (EST)
Message-ID: <46FDE0C2.5010207@pobox.com>
Date: Sat, 29 Sep 2007 01:21:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/9] fs_enet: Whitespace cleanup.
References: <20070920220116.GA28784@loki.buserror.net>
In-Reply-To: <20070920220116.GA28784@loki.buserror.net>
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

Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  drivers/net/fs_enet/fs_enet-main.c |   85 ++++++++++++++++-------------------
>  drivers/net/fs_enet/fs_enet.h      |    4 +-
>  drivers/net/fs_enet/mac-fcc.c      |    1 -
>  drivers/net/fs_enet/mii-bitbang.c  |    3 -
>  drivers/net/fs_enet/mii-fec.c      |    1 -
>  5 files changed, 41 insertions(+), 53 deletions(-)

ACK patches 1-2, 4-9

This patch doesn't apply cleanly to netdev-2.6.git#upstream (nor 
net-2.6.24.git), so this and the rest of the patch series failed to apply.

Please resend series on top of netdev-2.6.git#upstream or net-2.6.24.git.
