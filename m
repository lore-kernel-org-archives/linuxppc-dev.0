Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E78EDE373
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 23:00:16 +1000 (EST)
Message-Id: <68336EBA-D155-45AD-A878-C12A9B15243C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jason Jin <Jason.jin@freescale.com>
In-Reply-To: <1215480068-6235-1-git-send-email-Jason.jin@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] Minor fixes for 85xxds and 8536ds board.
Date: Wed, 9 Jul 2008 08:00:08 -0500
References: <1215480068-6235-1-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 7, 2008, at 8:21 PM, Jason Jin wrote:

> Remove the "uninitialized use" compile warning and
> avoid potential runtime issue.
>
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> ---
> arch/powerpc/platforms/85xx/mpc8536_ds.c |    2 +-
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

applied.

- k
