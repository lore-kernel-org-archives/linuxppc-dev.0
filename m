Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 238292C036B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 22:57:44 +1000 (EST)
Subject: Re: [PATCH v2 3/3] powerpc/mpc85xx_ds: convert to unified PCI init
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341966409-22660-4-git-send-email-scottwood@freescale.com>
Date: Wed, 11 Jul 2012 07:57:39 -0500
Message-Id: <4094FD1F-E9AE-40E1-A2B5-9333B063B281@kernel.crashing.org>
References: <1341966409-22660-1-git-send-email-scottwood@freescale.com>
 <1341966409-22660-4-git-send-email-scottwood@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 7:26 PM, Scott Wood wrote:

> Similar to how the primary PCI bridge is identified by looking
> for an isa subnode, we determine whether to apply uli exclusions
> by looking for a uli subnode.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v2: Rebased on Kumar's next
>=20
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |   97 =
+++++++++---------------------
> 1 files changed, 29 insertions(+), 68 deletions(-)

applied to next

- k=
