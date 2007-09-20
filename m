Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD554DDD0D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 14:18:29 +1000 (EST)
Message-ID: <46F1F490.2040605@garzik.org>
Date: Thu, 20 Sep 2007 00:18:24 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [FS_ENET] TX stuff should use fep->tx_lock,	instead
	of fep->lock.
References: <20070918160527.13525.80935.stgit@localhost.localdomain>
In-Reply-To: <20070918160527.13525.80935.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> 
> ---
> 
>  drivers/net/fs_enet/fs_enet-main.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

applied 1-2, after hand-editing the subject line to remove brackets from 
around "[FS_ENET]"

everything within [ and ] is removed, before copying to changelog, so 
please be careful

See http://linux.yyz.us/patch-format.html for more info.

	Jeff
