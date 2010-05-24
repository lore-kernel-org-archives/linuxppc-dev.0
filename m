Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E24BB7D82
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 May 2010 05:12:49 +1000 (EST)
Subject: Re: [PATCH v3 2/5] fsl_msi: enable msi allocation in all banks
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1271925099-29100-2-git-send-email-leoli@freescale.com>
Date: Mon, 24 May 2010 14:12:44 -0500
Message-Id: <4C3ED8E3-2925-47D5-9D6C-91F90BA30E39@kernel.crashing.org>
References: <1271925099-29100-1-git-send-email-leoli@freescale.com>
	<1271925099-29100-2-git-send-email-leoli@freescale.com>
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 22, 2010, at 3:31 AM, Li Yang wrote:

> Put all fsl_msi banks in a linked list. The list of banks then can be
> traversed when allocating new msi interrupts.  Also fix failing path
> of fsl_setup_msi_irqs().
> 
> Signed-off-by: Zhao Chenhui <b26998@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_msi.c |   14 +++++++++++---
> arch/powerpc/sysdev/fsl_msi.h |    2 ++
> 2 files changed, 13 insertions(+), 3 deletions(-)

applied to next

- k
