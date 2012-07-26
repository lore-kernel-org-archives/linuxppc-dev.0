Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3EFA32C03B8
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2012 04:54:04 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc/fsl-pci: add fsl,
 qoriq-pcie-v2.4 compatible string
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343315334-800-1-git-send-email-timur@freescale.com>
Date: Thu, 26 Jul 2012 13:54:02 -0500
Message-Id: <6B55E481-41E6-4570-9C4F-485E8FFE6CA9@kernel.crashing.org>
References: <1343315334-800-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 26, 2012, at 10:08 AM, Timur Tabi wrote:

> The PCI controller on the Freescale P5040 is v2.4.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied to next

- k
