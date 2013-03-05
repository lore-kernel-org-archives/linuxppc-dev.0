Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D5FF2C0353
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 07:29:28 +1100 (EST)
Date: Tue, 5 Mar 2013 14:29:16 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][v2] powerpc/e6500: Add Power ISA properties for e6500
 cores
To: Stuart Yoder <stuart.yoder@freescale.com>
References: <1362514602-17920-1-git-send-email-stuart.yoder@freescale.com>
In-Reply-To: <1362514602-17920-1-git-send-email-stuart.yoder@freescale.com>
 (from stuart.yoder@freescale.com on Tue Mar  5 14:16:42 2013)
Message-ID: <1362515356.25308.8@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/05/2013 02:16:42 PM, Stuart Yoder wrote:
> From: Stuart Yoder <stuart.yoder@freescale.com>
>=20
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> -v2
>    -fix some typos
>=20
>  arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi |   65 =20
> ++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi =20
> b/arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi
> new file mode 100644
> index 0000000..6b4d16a
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/e6500_power_isa.dtsi
> @@ -0,0 +1,65 @@
> +/*
> + * e6500 Power ISA Device Tree Source (include)
> + *
> + * Copyright 2013 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following =20
> conditions are met:
> + *     * Redistributions of source code must retain the above =20
> copyright
> + *       notice, this list of conditions and the following =20
> disclaimer.
> + *     * Redistributions in binary form must reproduce the above =20
> copyright
> + *       notice, this list of conditions and the following =20
> disclaimer in the
> + *       documentation and/or other materials provided with the =20
> distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote =20
> products
> + *       derived from this software without specific prior written =20
> permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms =20
> of the
> + * GNU General Public License ("GPL") as published by the Free =20
> Software
> + * Foundation, either version 2 of that License or (at your option) =20
> any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND =20
> ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE =20
> IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR =20
> PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE =20
> FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR =20
> CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS =20
> OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER =20
> CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT =20
> LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =20
> USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/ {
> +	cpus {
> +		power-isa-version =3D "2.06";
> +		power-isa-b;		// Base
> +		power-isa-e;		// Embedded
> +		power-isa-atb;		// Alternate Time Base
> +		power-isa-cs;		// Cache Specification
> +		power-isa-ds;		// Decorated Storage
> +		power-isa-e.ed;		// Embedded.Enhanced Debug
> +		power-isa-e.pd;		// Embedded.External PID
> +		power-isa-e.hv;		// Embedded.Hypervisor
> +		power-isa-e.le;		// Embedded.Little-Endian
> +		power-isa-e.pm;		// Embedded.Performance Monitor
> +		power-isa-e.pc;		// Embedded.Processor Control
> +		power-isa-ecl;		// Embedded Cache Locking
> +		power-isa-exp;		// External Proxy
> +		power-isa-fp;		// Floating Point
> +		power-isa-fp.r;		// Floating Point.Record
> +		power-isa-mmc;		// Memory Coherence
> +		power-isa-scpm;		// Store Conditional Page =20
> Mobility
> +		power-isa-wt;		// Wait
> +		power-isa-64;		// 64-bit
> +		power-isa-e.pt;		// Embedded.Page Table
> +		power-isa-e.hv.lrat;	// Embedded.Hypervisor.LRAT
> +		power-isa-e.em;		// Embedded Multi-Threading
> +		power-isa-v;		// Vector (AltiVec)
> +		power-isa-er;		// Enhanced Reservations (Load =20
> and Reserve and Store Cond.)
> +		power-isa-deo;		// Data Cache Extended =20
> Operations

ER and DEO are FSL EREF categories, not Power ISA categories.

-Scott=
