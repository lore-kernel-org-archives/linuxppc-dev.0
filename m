Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8D8922C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 04:23:59 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc/mpic: allow coreint to be determined by MPIC
 version
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
Date: Wed, 23 Jan 2013 11:23:51 -0600
Message-Id: <AAD002DB-C259-4054-A126-950B69BF1B5D@kernel.crashing.org>
References: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 21, 2013, at 7:56 PM, Scott Wood wrote:

> This will be used by the qemu-e500 platform, as the MPIC version (and
> thus whether we have coreint) depends on how QEMU is configured.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/sysdev/mpic.c |   26 +++++++++++++++++++++++---
> 1 file changed, 23 insertions(+), 3 deletions(-)

Is the idea that we'd set mpic->flags such that MPIC_ENABLE_COREINT was =
set, but based on the controller version we'd ignore the flag?

- k=
