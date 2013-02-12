Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B98472C04CF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 07:01:46 +1100 (EST)
Subject: Re: [PATCH 1/4] powerpc: split sbc8548 dts file into pre and post
 chunks
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1358972013-5271-2-git-send-email-paul.gortmaker@windriver.com>
Date: Tue, 12 Feb 2013 14:01:38 -0600
Message-Id: <49F72831-A7DB-4FDD-9FF5-E4B4B7F22E45@kernel.crashing.org>
References: <1358972013-5271-1-git-send-email-paul.gortmaker@windriver.com>
 <1358972013-5271-2-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 23, 2013, at 2:13 PM, Paul Gortmaker wrote:

> Updates to u-boot allow this board to boot off of either
> the 8MB soldered on flash, or the 64MB SODIMM flash.
>=20
> This is achieved by changing JP12 and SW2.8 which in turn
> swaps which flash device appears on /CS0 and /CS6 respectively.
>=20
> Since the flash devices are not the same size, this also
> changes the MTD memory map layout on the local bus.
>=20
> Here we split the common chunks out into a pre and post
> include, so they can be reused by an upcoming "alternative
> boot" dts file; leaving only the local bus chunk behind.
>=20
> No content changes are made at this point - it is just purely
> the move to using include files.
>=20
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/sbc8548-post.dtsi | 295 =
+++++++++++++++++++++++++++++
> arch/powerpc/boot/dts/sbc8548-pre.dtsi  |  52 ++++++
> arch/powerpc/boot/dts/sbc8548.dts       | 322 =
+-------------------------------
> 3 files changed, 351 insertions(+), 318 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/sbc8548-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/sbc8548-pre.dtsi

applied 1-4 to next

- k=
