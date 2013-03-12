Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E8D472C02F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 08:14:40 +1100 (EST)
Subject: Re: [PATCH][v3] powerpc/e6500: Add architecture categories for e6500
 cores
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362523149-19393-1-git-send-email-stuart.yoder@freescale.com>
Date: Tue, 12 Mar 2013 16:14:32 -0500
Message-Id: <163B3BFC-1296-44B1-9B10-195A4A481CF3@kernel.crashing.org>
References: <1362523149-19393-1-git-send-email-stuart.yoder@freescale.com>
To: Stuart Yoder <stuart.yoder@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2013, at 4:39 PM, Stuart Yoder wrote:

> From: Stuart Yoder <stuart.yoder@freescale.com>
>=20
> -also define a binding for fsl,eref-* properties
>=20
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
>=20
> -v3
>   -converted EREF specific properties to fsl,eref-*
>=20
> .../devicetree/bindings/powerpc/fsl/cpus.txt       |   21 +++++++
> arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi     |   65 =
++++++++++++++++++++
> 2 files changed, 86 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> create mode 100644 arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi

applied to next

- k=
