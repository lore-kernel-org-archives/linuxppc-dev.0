Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 61469B6FCA
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2012 04:21:28 +1100 (EST)
Subject: Re: [PATCH] powerpc/epapr: add "memory" as a clobber to all hypercalls
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331851262-1806-1-git-send-email-timur@freescale.com>
Date: Wed, 21 Mar 2012 12:21:24 -0500
Message-Id: <BF3D17B2-CB4C-4BA4-B418-A18253650AF5@kernel.crashing.org>
References: <1331851262-1806-1-git-send-email-timur@freescale.com>
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


On Mar 15, 2012, at 5:41 PM, Timur Tabi wrote:

> The "memory" clobber tells the compiler to ensure that all writes to =
memory
> are committed before the hypercall is made.
>=20
> "memory" is only necessary for hcalls where the Hypervisor will read =
or
> write guest memory. However, we add it to all hcalls because the =
impact is
> minimal, and we want to ensure that it's present for the hcalls that =
need it.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/include/asm/epapr_hcalls.h |    7 ++++++-
> 1 files changed, 6 insertions(+), 1 deletions(-)

applied

- k=
