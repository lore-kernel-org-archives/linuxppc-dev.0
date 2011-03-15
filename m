Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F461B6FE1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 02:40:04 +1100 (EST)
Subject: Re: [PATCH 2/2] dts: Update sata controller compatible for p1022ds
	board
MIME-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1295428050-21934-2-git-send-email-B33228@freescale.com>
Date: Tue, 15 Mar 2011 10:39:54 -0500
Message-ID: <D20B8B05-5AF1-4410-BA2D-A93B7C0ACD78@freescale.com>
References: <1295428050-21934-1-git-send-email-B33228@freescale.com>
	<1295428050-21934-2-git-send-email-B33228@freescale.com>
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

> Update p1022 sata compatible to "fsl,p1022-sata", "fsl,pq-sata-v2".
> p1022ds sata controller is v2 version comparing previous FSL sata
> controller, for example, mpc8536.
> 
> Signed-off-by: Lei Xu <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022ds.dts |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied

- k
