Return-Path: <B11780@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57069B6F72
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 13:19:13 +1000 (EST)
Received: from mail94-am1 (localhost.localdomain [127.0.0.1])	by
	mail94-am1-R.bigfish.com (Postfix) with ESMTP id 7E80511381A1	for
	<linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 03:19:09 +0000 (UTC)
Received: from AM1EHSMHS006.bigfish.com (unknown [10.3.201.247])	by
	mail94-am1.bigfish.com (Postfix) with ESMTP id 27C2418F8050	for
	<linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 03:19:09 +0000 (UTC)
Subject: Re: [PATCH] [v2] powerpc/85xx: enable the audio drivers in the
	defconfigs
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1313534679-7523-1-git-send-email-timur@freescale.com>
Date: Tue, 30 Aug 2011 22:19:02 -0500
Message-ID: <ECDC9E5C-7903-4CA3-95A0-6A739020CFE1@freescale.com>
References: <1313534679-7523-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 16, 2011, at 5:44 PM, Timur Tabi wrote:

> Enable the audio drivers in the non-corenet 85xx defconfigs so that audio
> is enabled on the Freescale P1022DS reference board.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/configs/mpc85xx_defconfig     |    1 +
> arch/powerpc/configs/mpc85xx_smp_defconfig |    1 +
> 2 files changed, 2 insertions(+), 0 deletions(-)

applied to merge

- k
