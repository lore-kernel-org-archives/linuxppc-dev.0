Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 837C7DE2FD
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 01:07:32 +1000 (EST)
Message-Id: <DD7C4D21-6338-4331-977C-F5F920B2FF90@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Rigby <jcrigby@gmail.com>
In-Reply-To: <4b73d43f0806172112s63ada35brb2e27f3262d7c07@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/2] fs_enet: fix checkpatch.pl problems
Date: Wed, 18 Jun 2008 10:07:00 -0500
References: <1213743794-3537-1-git-send-email-jrigby@freescale.com>
	<1213743794-3537-2-git-send-email-jrigby@freescale.com>
	<485886D9.5070800@garzik.org>
	<4b73d43f0806172112s63ada35brb2e27f3262d7c07@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Sam Ravnborg <sam@ravnborg.org>, Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2008, at 11:12 PM, John Rigby wrote:

> Sorry, I thought I was doing the right thing to base the patch on  
> Kumar's patch that removes the CONFIG_PPC_CPM_NEW_BINDING stuff.   
> That is likely why it did not apply.

It is the right thing, we just need to work out the logistics here.   
Jeff, would you be willing to pull the following patch into your tree:

http://patchwork.ozlabs.org/linuxppc/patch?q=gala&filter=incoming&id=18939

(I can resend it to you if needed.  It seems better for you to have  
this patch in your tree to allow further development on the work John  
is doing)

- k

> On Tue, Jun 17, 2008 at 9:54 PM, Jeff Garzik <jeff@garzik.org> wrote:
> John Rigby wrote:
> Fixed all errors and warnings that checkpatch.pl
> reports if this was a new submission.
> Also changed instances of fec_t to struct fec in
> mac-fec.c and mii-fec.c.
>
> This is in preparation of adding MPC5121 support.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
>  drivers/net/fs_enet/fs_enet-main.c |   70 +++++++++++++++++++ 
> +---------------
>  drivers/net/fs_enet/fs_enet.h      |   15 +++++---
>  drivers/net/fs_enet/mac-fcc.c      |    7 ++--
>  drivers/net/fs_enet/mac-fec.c      |   40 ++++++++++----------
>  drivers/net/fs_enet/mac-scc.c      |   13 ++++---
>  drivers/net/fs_enet/mii-bitbang.c  |    4 +-
>  drivers/net/fs_enet/mii-fec.c      |   23 +++++++-----
>  7 files changed, 95 insertions(+), 77 deletions(-)
>
> patch does not apply
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
