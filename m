Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 963752C03CA
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2012 04:54:21 +1000 (EST)
Subject: Re: [PATCH 2/3] [v2] powerpc/85xx: add Freescale P5040 SOC and SEC
 v5.2 device trees
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343315334-800-2-git-send-email-timur@freescale.com>
Date: Thu, 26 Jul 2012 13:54:18 -0500
Message-Id: <1F228996-BB84-4643-9AC2-A699E304AE17@kernel.crashing.org>
References: <1343315334-800-1-git-send-email-timur@freescale.com>
 <1343315334-800-2-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 26, 2012, at 10:08 AM, Timur Tabi wrote:

> From: Kim Phillips <kim.phillips@freescale.com>
>=20
> Add device tree (dtsi) files for the Freescale P5040 SOC.  Since this
> SOC introduces SEC v5.2, add the dtsi file for that also.
>=20
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/p5040si-post.dtsi   |  320 =
+++++++++++++++++++++++++
> arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi    |  111 +++++++++
> arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi |  118 +++++++++
> 3 files changed, 549 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi

applied to next

- k=
