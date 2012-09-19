Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F19722C016D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 00:52:31 +1000 (EST)
Subject: Re: [PATCH] powerpc/mpc85xx:Update interrupt handling for IFC
 controller
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1347523451-7843-1-git-send-email-prabhakar@freescale.com>
Date: Wed, 19 Sep 2012 09:52:04 -0500
Message-Id: <9C9D71F3-2724-4E0E-A313-6706B5ACCEBB@kernel.crashing.org>
References: <1347523451-7843-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 13, 2012, at 3:04 AM, Prabhakar Kushwaha wrote:

> IFC may have one or two interrupts.  If two interrupt specifiers are =
present,
> the first is the "common" interrupt (CM_EVTER_STAT), and the second is =
the NAND
> interrupt (NAND_EVTER_STAT).
> If there is only one, that interrupt reports both types of event.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git branch =
next=20
>=20
> arch/powerpc/sysdev/fsl_ifc.c |   20 ++++++++------------
> 1 file changed, 8 insertions(+), 12 deletions(-)

applied to next

- k=
