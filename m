Return-Path: <Ian.Campbell@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "mail.citrix.com",
 Issuer "Cybertrust Public SureServer SV CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7AE662C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 19:16:25 +1000 (EST)
Message-ID: <1380013893.23688.10.camel@kazak.uk.xensource.com>
Subject: Re: [PATCH] powerpc/dts/virtex440: declare address/size-cells for
 phy device
From: Ian Campbell <Ian.Campbell@citrix.com>
To: <linux-kernel@vger.kernel.org>
Date: Tue, 24 Sep 2013 10:11:33 +0100
In-Reply-To: <1370257241-23923-1-git-send-email-ian.campbell@citrix.com>
References: <1370257241-23923-1-git-send-email-ian.campbell@citrix.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Gernot Vormayr <gvormayr@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-06-03 at 12:00 +0100, Ian Campbell wrote:
> This fixes a warning:
> 
>   DTC     arch/powerpc/boot/virtex440-ml507.dtb
> Warning (reg_format): "reg" property in /plb@0/xps-ll-temac@81c00000/ethernet@81c00000/phy@7 has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /plb@0/xps-ll-temac@81c00000/ethernet@81c00000/phy@7
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /plb@0/xps-ll-temac@81c00000/ethernet@81c00000/phy@7

I still see this in v3.12-rc2. Ping?

> 
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Gernot Vormayr <gvormayr@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/powerpc/boot/dts/virtex440-ml507.dts |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/virtex440-ml507.dts b/arch/powerpc/boot/dts/virtex440-ml507.dts
> index fc7073b..391a4e2 100644
> --- a/arch/powerpc/boot/dts/virtex440-ml507.dts
> +++ b/arch/powerpc/boot/dts/virtex440-ml507.dts
> @@ -257,6 +257,8 @@
>  			#size-cells = <1>;
>  			compatible = "xlnx,compound";
>  			ethernet@81c00000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
>  				compatible = "xlnx,xps-ll-temac-1.01.b";
>  				device_type = "network";
>  				interrupt-parent = <&xps_intc_0>;
