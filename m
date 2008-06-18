Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72CB9DDECA
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 13:54:08 +1000 (EST)
Message-ID: <485886D9.5070800@garzik.org>
Date: Tue, 17 Jun 2008 23:54:01 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 1/2] fs_enet: fix checkpatch.pl problems
References: <1213743794-3537-1-git-send-email-jrigby@freescale.com>
	<1213743794-3537-2-git-send-email-jrigby@freescale.com>
In-Reply-To: <1213743794-3537-2-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Sam Ravnborg <sam@ravnborg.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rigby wrote:
> Fixed all errors and warnings that checkpatch.pl
> reports if this was a new submission.
> Also changed instances of fec_t to struct fec in
> mac-fec.c and mii-fec.c.
> 
> This is in preparation of adding MPC5121 support.
> 
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
>  drivers/net/fs_enet/fs_enet-main.c |   70 ++++++++++++++++++++---------------
>  drivers/net/fs_enet/fs_enet.h      |   15 +++++---
>  drivers/net/fs_enet/mac-fcc.c      |    7 ++--
>  drivers/net/fs_enet/mac-fec.c      |   40 ++++++++++----------
>  drivers/net/fs_enet/mac-scc.c      |   13 ++++---
>  drivers/net/fs_enet/mii-bitbang.c  |    4 +-
>  drivers/net/fs_enet/mii-fec.c      |   23 +++++++-----
>  7 files changed, 95 insertions(+), 77 deletions(-)

patch does not apply
