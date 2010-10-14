Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31BB41007E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 17:08:41 +1100 (EST)
Subject: Re: [PATCH 1/3] fsl_rio: Add comments for sRIO registers.
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1287021842-22015-1-git-send-email-b21989@freescale.com>
Date: Thu, 14 Oct 2010 01:08:25 -0500
Message-Id: <5596F1CC-C625-4866-B784-1ADAD52617A4@kernel.crashing.org>
References: <1287021842-22015-1-git-send-email-b21989@freescale.com>
To: Shaohui Xie <b21989@freescale.com>
Cc: alexandre.bounine@idt.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2010, at 9:04 PM, Shaohui Xie wrote:

> Add some comments to make sRIO registers map better readable.
>=20
> Signed-off-by: Shaohui Xie <b21989@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_rio.c |   65 =
+++++++++++++++++++++++++----------------
> 1 files changed, 40 insertions(+), 25 deletions(-)

applied to next

- k=
