Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 336C82C02A6
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2013 08:14:58 +1100 (EST)
Subject: Re: [PATCH 1/8] powerpc/85xx: Added SEC-5.0 device tree.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
Date: Tue, 12 Mar 2013 16:14:43 -0500
Message-Id: <827D7026-EB93-428C-861F-58584C2ED0A8@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Vakul Garg <vakul@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2013, at 5:15 PM, Kumar Gala wrote:

> From: Vakul Garg <vakul@freescale.com>
>=20
> Add device tree for SEC (crypto engine) version 5.0 used on T4240.
>=20
> Signed-off-by: Vakul Garg <vakul@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi |  109 =
+++++++++++++++++++++++++
> 1 file changed, 109 insertions(+)
> create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi

applied to next

- k=
