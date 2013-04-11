Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 201832C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 23:34:12 +1000 (EST)
Subject: Re: [PATCH] powerpc/crypto: removed qoriq-sec4.1-0.dtsi.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1365651819-23350-1-git-send-email-vakul@freescale.com>
Date: Thu, 11 Apr 2013 08:33:52 -0500
Message-Id: <DBED8846-60EE-41F8-B4C3-F24B3C1AB152@kernel.crashing.org>
References: <1365651819-23350-1-git-send-email-vakul@freescale.com>
To: Vakul Garg <vakul@freescale.com>
Cc: Shaveta Leekha <shaveta@freescale.com>, linux-kernel@vger.kernel.org,
 Andy Fleming <afleming@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 10, 2013, at 10:43 PM, Vakul Garg wrote:

> Removing qoriq-sec4.1-0.dtsi as it is not used by any soc anymore.
>=20
> Signed-off-by: Vakul Garg <vakul@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi |  109 =
-------------------------
> 1 files changed, 0 insertions(+), 109 deletions(-)
> delete mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi

applied to next

- k=
