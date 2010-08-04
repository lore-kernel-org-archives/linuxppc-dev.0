Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5559A100A3D
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 05:16:05 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/85xx: Fix booting for P1021MDS boards
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100608195550.GB11446@oksana.dev.rtsoft.ru>
Date: Wed, 4 Aug 2010 14:15:52 -0500
Message-Id: <7A23589D-05C4-486E-83F2-7A4EF0F48B81@kernel.crashing.org>
References: <20100608195550.GB11446@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 8, 2010, at 2:55 PM, Anton Vorontsov wrote:

> P1021 processors have no dedicated ROM to store the QE microcode,
> so the fimrware is stored externally, and it is U-Boot responsibility
> to load it. It might be that the board is booting without QE, e.g.
> currently U-Boot doesn't support QE for P1021MDS boards, which means
> that QE isn't initialized, and so the board hangs early at boot.
>=20
> This patch fixes the issue by marking QE as disabled and checking the
> state in the probing code. U-Boot should fixup the state if it
> initialized the QE.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> arch/powerpc/boot/dts/p1021mds.dts        |    1 +
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |   43 =
+++++++++++++++++++++++++----
> 2 files changed, 38 insertions(+), 6 deletions(-)

applied to next

- k=
