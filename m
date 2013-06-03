Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F1212C0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 08:43:59 +1000 (EST)
Date: Mon, 3 Jun 2013 17:43:05 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 05/15] fsl_pmc: update device bindings
To: Zhao Chenhui <chenhui.zhao@freescale.com>
References: <1366368468-29143-1-git-send-email-chenhui.zhao@freescale.com>
 <1366368468-29143-5-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1366368468-29143-5-git-send-email-chenhui.zhao@freescale.com>
 (from chenhui.zhao@freescale.com on Fri Apr 19 05:47:38 2013)
Message-ID: <1370299385.21388.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/2013 05:47:38 AM, Zhao Chenhui wrote:
> From: Li Yang <leoli@freescale.com>
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/pmc.txt        |   59 =20
> +++++++++++--------
>  1 files changed, 34 insertions(+), 25 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt =20
> b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
> index 07256b7..f1f749f 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
> @@ -9,15 +9,20 @@ Properties:
>=20
>    "fsl,mpc8548-pmc" should be listed for any chip whose PMC is
>    compatible.  "fsl,mpc8536-pmc" should also be listed for any chip
> -  whose PMC is compatible, and implies deep-sleep capability.
> +  whose PMC is compatible, and implies deep-sleep capability and
> +  wake on user defined packet(wakeup on ARP).
> +
> +  "fsl,p1022-pmc" should be listed for any chip whose PMC is
> +  compatible, and implies lossless Ethernet capability during sleep.
>=20
>    "fsl,mpc8641d-pmc" should be listed for any chip whose PMC is
>    compatible; all statements below that apply to "fsl,mpc8548-pmc" =20
> also
>    apply to "fsl,mpc8641d-pmc".
>=20
>    Compatibility does not include bit assignments in =20
> SCCR/PMCDR/DEVDISR; these
> -  bit assignments are indicated via the sleep specifier in each =20
> device's
> -  sleep property.
> +  bit assignments are indicated via the clock nodes.  Device which =20
> has a
> +  controllable clock source should have a "fsl,pmc-handle" property =20
> pointing
> +  to the clock node.

Please respond to the feedback given on v1:
http://patchwork.ozlabs.org/patch/147177/

Also indicate, below the ---, what has changed from previous versions.

-Scott=
