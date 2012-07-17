Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4487C2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 23:39:46 +1000 (EST)
Subject: Re: [PATCH] powerpc/p3041: change espi input-clock from 40MHz to 35MHz
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342509511-13942-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Tue, 17 Jul 2012 08:39:44 -0500
Message-Id: <36D80E45-2CCD-4BD9-9D59-AD3B174D52A8@kernel.crashing.org>
References: <1342509511-13942-1-git-send-email-Shaohui.Xie@freescale.com>
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


On Jul 17, 2012, at 2:18 AM, Shaohui Xie wrote:

> Default CCB on P3041 is 750MHz, but espi cannot work at 40MHz with =
this CCB,
> so we need to slow down the clock rate of espi to 35MHz to make it =
work stable
> with the CCB.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> arch/powerpc/boot/dts/p3041ds.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next

- k=
