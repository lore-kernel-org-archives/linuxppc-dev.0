Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 88C7CB6FA1
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 06:07:45 +1100 (EST)
Subject: Re: [PATCH 2/2] [v2] powerpc/fsl: add PAMUBYPENR register definition
 to fsl_guts.h
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1329412870-16716-2-git-send-email-timur@freescale.com>
Date: Fri, 16 Mar 2012 14:07:42 -0500
Message-Id: <431FD642-F157-4B73-8954-C294A5C107C2@kernel.crashing.org>
References: <1329412870-16716-1-git-send-email-timur@freescale.com>
 <1329412870-16716-2-git-send-email-timur@freescale.com>
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


On Feb 16, 2012, at 11:21 AM, Timur Tabi wrote:

> Add a defintion of register PAMUBYPENR (offset 0x604) to the global
> utilities structure.
>=20
> PAMUBYPENR is the PAMU bypass enable register.  It contains control
> bits for enabling bypass mode on each PAMU.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/include/asm/fsl_guts.h |    4 +++-
> 1 files changed, 3 insertions(+), 1 deletions(-)

Sticking with my original point of not applying this til PAMU driver is =
ready as well.

- k=
