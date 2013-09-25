Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9730E2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 10:02:35 +1000 (EST)
Received: from mail27-db9 (localhost [127.0.0.1])	by mail27-db9-R.bigfish.com
 (Postfix) with ESMTP id C44A4401DD	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 25 Sep 2013 00:02:29 +0000 (UTC)
Received: from DB9EHSMHS014.bigfish.com (unknown [10.174.16.237])	by
 mail27-db9.bigfish.com (Postfix) with ESMTP id 672094E009D	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 00:02:27 +0000 (UTC)
Message-ID: <1380067297.24959.163.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2][v4] powerpc/fsl-booke: Add initial T104x_QDS board
 support
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Tue, 24 Sep 2013 19:01:37 -0500
In-Reply-To: <1379908288-7804-1-git-send-email-prabhakar@freescale.com>
References: <1379908288-7804-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-23 at 09:21 +0530, Prabhakar Kushwaha wrote:
> +/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
> +	.get_irq		= mpic_get_coreint_irq,

Remove the comment.

Also note Kevin's patch to consolidate on a common corenet board file.

-Scott
