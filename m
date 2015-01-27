Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6978E1A054F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 07:20:08 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
Date: Tue, 27 Jan 2015 21:13:51 +0100
Message-ID: <4747424.udeKOcy6tC@wuerfel>
In-Reply-To: <1422379260-10139-3-git-send-email-stripathi@apm.com>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <1422379260-10139-3-git-send-email-stripathi@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com, jcm@redhat.com,
 anton@enomsg.org, linux-mmc@vger.kernel.org, chris@printf.net, patches@apm.com,
 ddutile@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 27 January 2015 22:51:00 Suman Tripathi wrote:
> 
> +               sdhc0: sdhc@1c000000 {
> +                       device_type = "sdhc";
> +                       compatible = "arasan,sdhci-8.9a";
> +                       reg = <0x0 0x1c000000 0x0 0x100>;
> +                       interrupts = <0x0 0x49 0x4>;
> +                       clock-names = "clk_xin", "clk_ahb";
> +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
> +               };
> +

Here you don't provide an 'iommus' property, which means that the
device is unable to use the iommu.

	Arnd
