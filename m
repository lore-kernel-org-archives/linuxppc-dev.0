Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2mrw5sSGzDrDw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 02:43:12 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org,
	scottwood@freescale.com
CC: aperez@alexperez.com
Date: Wed, 05 Jul 2017 16:37:32 +0100 (BST)
Message-ID: <4a50d6ac656.574a05c2@auth.smtp.1and1.co.uk>
In-Reply-To: <1477266519-25173-2-git-send-email-afleming@gmail.com>
References: <1477266519-25173-1-git-send-email-afleming@gmail.com>
 <1477266519-25173-2-git-send-email-afleming@gmail.com>
Subject: Re: 85xx: Enable gpio power/reset driver
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott

On 23/10/2016, Andy Fleming wrote:
> These config changes build:
> drivers/power/reset/gpio-poweroff.c
> drivers/power/reset/gpio-restart.c
>
> Signed-off-by: Andy Fleming <afleming@gmail.com>
> ---
>  arch/powerpc/configs/fsl-emb-nonhw.config | 6 ++++++
>  1 file changed, 6 insertions(+)

Is there any news on when these patches will be merged? We have end-users with
Cyrus boards now, and would like to provide them with a mainline kernel that
can power-off/reset the board.

Thanks
Darren
