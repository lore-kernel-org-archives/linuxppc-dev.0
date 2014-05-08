Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1DECA1400B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 00:01:06 +1000 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2] powerpc/fsl: Added binding for Freescale CoreNet
 coherency fabric (CCF)
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1397833917-12611-1-git-send-email-diana.craciun@freescale.com>
Date: Thu, 8 May 2014 07:00:44 -0700
Message-Id: <6CE62BBF-BFF4-4F2C-8EFF-B6F87EE6EEE9@kernel.crashing.org>
References: <1397833917-12611-1-git-send-email-diana.craciun@freescale.com>
To: Diana Craciun <diana.craciun@freescale.com>
Cc: scottwood@freescale.com, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 18, 2014, at 8:11 AM, Diana Craciun <diana.craciun@freescale.com> =
wrote:

> From: Diana Craciun <Diana.Craciun@freescale.com>
>=20
> The CoreNet coherency fabric is a fabric-oriented, conectivity
> infrastructure that enables the implementation of coherent, multicore
> systems. The CCF acts as a central interconnect for cores,
> platform-level caches, memory subsystem, peripheral devices and I/O =
host
> bridges in the system.
>=20
> Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
> ---
> .../devicetree/bindings/powerpc/fsl/ccf.txt        | 36 =
++++++++++++++++++++++
> 1 file changed, 36 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt =
b/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
> new file mode 100644
> index 0000000..f0b7143
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
> @@ -0,0 +1,36 @@
> +Freescale CoreNet Coherency Fabric(CCF) Device Tree Binding
> +
> +DESCRIPTION
> +
> +The CoreNet coherency fabric is a fabric-oriented, connectivity =
infrastructure
> +that enables the implementation of coherent, multicore systems.
> +
> +Required properties:
> +
> +- compatible : <string>
> +		Must include "fsl,corenetX-cf", "fsl,corenet-cf" - =
CoreNet coherency=20
> +		fabric version X

Can we make this =91fsl,corenet-vX-cf=92.

corenet-v1-cf/corenet-v2-cf looks nicer than corenet1-cf/corenet2-cf

> +
> +- reg : <prop-encoded-array>
> +		A standard property. Represents the CCF registers.
> +
> +- interrupts : <prop-encoded-array>
> +		Interrupt mapping for CCF error interrupt.
> +
> +- fsl,ccf-num-csdids: <u32>
> +		Specifies the number of Coherency Subdomain ID Port =
Mapping
> +		Registers that are supported by the CCF.
> +
> +- fsl,ccf-num-snoopids: <u32>
> +		Specifies the number of Snoop ID Port Mapping Registers =
that
> +		are supported by CCF.
> +
> +Example:
> +
> +	corenet-cf@18000 {
> +		compatible =3D "fsl,corenet2-cf", "fsl,corenet-cf";
> +		reg =3D <0x18000 0x1000>;
> +		interrupts =3D <16 2 1 31>;
> +		fsl,ccf-num-csdids =3D <32>;
> +		fsl,ccf-num-snoopids =3D <32>;
> +	};
> --=20
> 1.7.11.7
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
