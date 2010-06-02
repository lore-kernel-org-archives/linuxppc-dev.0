Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F0B8B7D1D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jun 2010 07:59:31 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix ioremap_flags() with book3e pte definition
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1274726319-4673-1-git-send-email-galak@kernel.crashing.org>
Date: Wed, 2 Jun 2010 16:59:16 -0500
Message-Id: <81DFFD59-BF21-4754-B006-805CFDC09576@kernel.crashing.org>
References: <1274726319-4673-1-git-send-email-galak@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 24, 2010, at 1:38 PM, Kumar Gala wrote:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> We can't just clear the user read permission in book3e pte, because
> that will also clear supervisor read permission.  This surely isn't
> desired.  Fix the problem by adding the supervisor read back.
>=20
> BenH: Slightly simplified the ifdef and applied to ppc64 too
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> For 2.6.34 stable commit 55052eeca6d71d76f7c3f156c0501814d8e5e6d3
>=20
> arch/powerpc/mm/pgtable_32.c |    8 ++++++++
> arch/powerpc/mm/pgtable_64.c |    8 ++++++++
> 2 files changed, 16 insertions(+), 0 deletions(-)

Wondering what happened to this patch (and 2 other) getting into stable =
queue for .34.x

- k=
