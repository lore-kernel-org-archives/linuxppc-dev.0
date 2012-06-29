Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E414EB700A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 06:03:54 +1000 (EST)
Subject: Re: [PATCH] powerpc/p2041rdb: add NAND node in device tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1340962871-10617-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Fri, 29 Jun 2012 15:03:52 -0500
Message-Id: <513504D9-43C0-4205-A33E-0C42C2E0AF9E@kernel.crashing.org>
References: <1340962871-10617-1-git-send-email-Shaohui.Xie@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 29, 2012, at 4:41 AM, Shaohui Xie wrote:

> NAND on p2041 uses CS1 as chip select.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> arch/powerpc/boot/dts/p2041rdb.dts |   41 =
+++++++++++++++++++++++++++++++++++-
> 1 files changed, 40 insertions(+), 1 deletions(-)

applied

- k=
