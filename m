Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23C12B6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Apr 2011 23:11:41 +1000 (EST)
Subject: Re: [PATCH] driver/e1000e: Fix default interrupt mode select
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1302503898-22023-1-git-send-email-prabhakar@freescale.com>
Date: Mon, 11 Apr 2011 08:11:30 -0500
Message-Id: <EBA6D042-CAC3-4C17-A14B-767D3FB075B5@kernel.crashing.org>
References: <1302503898-22023-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: meet2prabhu@gmail.com, linuxppc-dev@lists.ozlabs.org,
	Jin Qing <b24347@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 11, 2011, at 1:38 AM, Prabhakar Kushwaha wrote:

> From: Prabhakar <prabhakar@freescale.com>
>=20
> e1000 default interrupt mode is MSI. No matter user select MSI or
> disable MSI in kernel config.
>=20
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branc=
h master)
>=20
> drivers/net/e1000e/param.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)

You should send this to netdev and CC the e1000e Maintainer.

- k=
