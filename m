Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0897B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 18:29:15 +1000 (EST)
Subject: Re: [PATCH v2] powerpc/85xx: fix mpic configuration in CAMP mode
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1310456983-1473-1-git-send-email-fabio.baltieri@gmail.com>
Date: Fri, 22 Jul 2011 03:28:58 -0500
Message-Id: <CA92D37F-3668-496A-869C-95D44FEB9837@kernel.crashing.org>
References: <20110711143859.0e6c95d8@schlenkerla.am.freescale.net>
	<1310456983-1473-1-git-send-email-fabio.baltieri@gmail.com>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
	Poonam Aggrwal <poonam.aggrwal@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 12, 2011, at 2:49 AM, Fabio Baltieri wrote:

> Change the string to check for CAMP mode boot on MPC85xx (eg. P2020) =
to match
> the one in the corresponding dts files (p2020rdb_camp_core{0,1}.dts).
>=20
> Without this fix the mpic is configured as in the SMP boot mode, which =
causes
> the first core to report a protected source interrupt error for =
devices
> of the other core and lock up.
>=20
> Also add MPIC_SINGLE_DEST_CPU on both P2020 based architectures in =
CAMP
> mode as suggested by Scott Wood. Thanks.
>=20
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_ds.c  |    3 ++-
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |    5 +++--
> 2 files changed, 5 insertions(+), 3 deletions(-)

applied to next

- k=
