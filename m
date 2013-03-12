Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 604932C06EE
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2013 08:17:16 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r2CLGt1w002377
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Mar 2013 16:17:13 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1278)
Subject: Re: [PATCH 7/8] powerpc/fsl-booke: Add initial T4240QDS board support
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-7-git-send-email-galak@kernel.crashing.org>
Date: Tue, 12 Mar 2013 16:16:04 -0500
Message-Id: <CBAA9220-A50A-4E72-AEFE-F9749063BAC2@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-3-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-4-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-5-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-6-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-7-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2013, at 5:15 PM, Kumar Gala wrote:

> Some minor changes to the common corenet_ds.c code are needed to =
support
> the T4240QDS:
> * Add support for "fsl,qoriq-pcie-v3.0" controller
> * Bump max # of IRQs to 512 (T4240 supports more interrupts than
>  previous SoCs).
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/platforms/85xx/Kconfig      |   17 ++++++
> arch/powerpc/platforms/85xx/Makefile     |    1 +
> arch/powerpc/platforms/85xx/corenet_ds.c |    5 +-
> arch/powerpc/platforms/85xx/t4240_qds.c  |   98 =
++++++++++++++++++++++++++++++
> 4 files changed, 120 insertions(+), 1 deletion(-)
> create mode 100644 arch/powerpc/platforms/85xx/t4240_qds.c

applied to next

- k=
