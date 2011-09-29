Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E68F51007DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Sep 2011 00:21:28 +1000 (EST)
Subject: Re: [PATCH 1/4] fsl-rio: Split rio driver into two parts,
	RapidIO endpoint and RapidIO message unit
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1317263341-19010-1-git-send-email-Gang.Liu@freescale.com>
Date: Thu, 29 Sep 2011 09:21:34 -0500
Message-Id: <E143A9DC-91AC-4623-879B-AA3A80A916AC@kernel.crashing.org>
References: <1317263341-19010-1-git-send-email-Gang.Liu@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Cc: r58472@freescale.com, linux-kernel@vger.kernel.org, r61911@freescale.com,
	Lian Minghuan-B31939 <Minghuan.Lian@freescale.com>,
	B11780@freescale.com, linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 28, 2011, at 9:28 PM, Liu Gang wrote:

> The Freescale PowerPC RapidIO controller consists of a RapidIO =
endpoint and a RapidIO
> message unit(RMU). Or use RapidIO message manager(RMan) to replace the =
RMU in DPAA
> architecture. Therefore, we should split the code into two function =
modules according
> to the hardware architecture.
> Add new struct for RMU module, and new initialization function to set =
up RMU module. This policy
> is very conducive to adding new module like RMan, or adding =
multi-ports or message units support.
>=20
> Signed-off-by: Lian Minghuan-B31939 <Minghuan.Lian@freescale.com>
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
> arch/powerpc/sysdev/Makefile  |    2 +-
> arch/powerpc/sysdev/fsl_rio.c | 1152 =
+---------------------------------------
> arch/powerpc/sysdev/fsl_rio.h |   78 +++
> arch/powerpc/sysdev/fsl_rmu.c | 1163 =
+++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 1267 insertions(+), 1128 deletions(-)
> create mode 100644 arch/powerpc/sysdev/fsl_rio.h
> create mode 100644 arch/powerpc/sysdev/fsl_rmu.c

Fix commit message so it doesn't go based 75 char column line wrap (same =
comment for other patches in the series)

- k=
