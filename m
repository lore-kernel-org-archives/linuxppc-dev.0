Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2CA0DB7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 02:55:08 +1100 (EST)
Subject: Re: [PATCH 1/2] ATA: Add FSL sata v2 controller support
MIME-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1295428050-21934-1-git-send-email-B33228@freescale.com>
Date: Tue, 15 Mar 2011 10:39:46 -0500
Message-ID: <F1C7AE8B-477C-478D-953A-064FD13CF859@freescale.com>
References: <1295428050-21934-1-git-send-email-B33228@freescale.com>
To: Xulei <B33228@freescale.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 19, 2011, at 3:07 AM, Xulei wrote:

> In FSL sata v2 block, the snoop bit of PRDT Word3 description
> information is at bit28 instead of bit22.
> 
> This patch adds FSL sata v2 probe and resolve this difference.
> 
> Signed-off-by: Lei Xu <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Acked-by: Jeff Garzik <jgarzik@redhat.com>
> ---
> drivers/ata/sata_fsl.c |   25 ++++++++++++++++++-------
> 1 files changed, 18 insertions(+), 7 deletions(-)

applied

- k
