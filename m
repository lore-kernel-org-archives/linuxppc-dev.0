Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0100B2C0259
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 21:02:51 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/85xx: add hardware automatically enter
 altivec idle state
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1376637789-27330-1-git-send-email-dongsheng.wang@freescale.com>
Date: Fri, 16 Aug 2013 06:02:56 -0500
Message-Id: <83499AB5-DCE7-407D-AEC1-B2493D1D38BE@kernel.crashing.org>
References: <1376637789-27330-1-git-send-email-dongsheng.wang@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 16, 2013, at 2:23 AM, Dongsheng Wang wrote:

> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> Each core's AltiVec unit may be placed into a power savings mode
> by turning off power to the unit. Core hardware will automatically
> power down the AltiVec unit after no AltiVec instructions have
> executed in N cycles. The AltiVec power-control is triggered by =
hardware.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

Why treat this as a idle HW governor vs just some one time setup at boot =
of the time delay?

- k=
