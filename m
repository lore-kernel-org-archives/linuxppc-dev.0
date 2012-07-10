Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 33C762C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 04:31:19 +1000 (EST)
Subject: Re: [PATCH 3/3] powerpc/mpc85xx_ds: convert to unified PCI init
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120627235007.GC9100@tyr.buserror.net>
Date: Tue, 10 Jul 2012 13:31:12 -0500
Message-Id: <5161DCF6-1A2F-42D6-8298-D8DFAA6CDD18@kernel.crashing.org>
References: <20120627235007.GC9100@tyr.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 27, 2012, at 6:50 PM, Scott Wood wrote:

> Similar to how the primary PCI bridge is identified by looking
> for an isa subnode, we determine whether to apply uli exclusions
> by looking for a uli subnode.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Besides being an example of a real-hardware board to use the new PCI =
init
> (probably one of the more complicated examples due to the uli device
> exclusion), this fixes PCI under QEMU's mpc8544ds machine.  QEMU was
> only creating one PCI bus, and it wasn't the one Linux had arbitrarily
> deemed primary for mpc8544ds (AFAIK, there's no legacy ISA on this
> board).
>=20
> Tested with QEMU mpc8544ds, and real-hardware mpc8572ds (with uli).
>=20
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |   97 =
+++++++++---------------------
> 1 files changed, 29 insertions(+), 68 deletions(-)

Can you rebase against my 'next' branch.. having issues applying this.

- k=
