Return-Path: <ulf.hansson@linaro.org>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com
 [IPv6:2a00:1450:400c:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFh3x73rrzDqRk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 17:44:13 +1000 (AEST)
Received: by mail-wm0-x233.google.com with SMTP id n129so213163962wmn.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 00:44:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <HE1PR04MB0889852B7809A1CCFF8922ACF8410@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <4448030.Zs8fVnr3nm@wuerfel>
 <HE1PR04MB0889B52134A43C0E7A452B7BF87C0@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <5159406.HOFrj7pRfW@wuerfel>
 <1462937186.16584.77.camel@buserror.net>
 <HE1PR04MB0889852B7809A1CCFF8922ACF8410@HE1PR04MB0889.eurprd04.prod.outlook.com>
Date: Thu, 26 May 2016 09:44:10 +0200
Message-ID: <CAPDyKFqx2JMLzXoDxGCKFYMFV47+SegnkuWFXKvsQHK7L5w-1g@mail.gmail.com>
Subject: Re: [v10,
 7/7] mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Scott Wood <oss@buserror.net>, Arnd Bergmann <arnd@arndb.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Kumar Gala <galak@codeaurora.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yang-Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Qiang Zhao <qiang.zhao@nxp.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26 May 2016 at 06:05, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> Hi Uffe,
>
> Could we merge this patchset? ...
> It has been a long time to wait for Arnd's response...
>
> Thanks a lot.
>
>

As we are still in the merge window I won't queue anything but fixes.
Let's give Arnd another week or so to respond.

Kind regards
Uffe

> Best regards,
> Yangbo Lu
>
>
>> -----Original Message-----
>> From: Yangbo Lu
>> Sent: Friday, May 20, 2016 2:06 PM
>> To: 'Scott Wood'; Arnd Bergmann; linux-arm-kernel@lists.infradead.org
>> Cc: linuxppc-dev@lists.ozlabs.org; Mark Rutland;
>> devicetree@vger.kernel.org; ulf.hansson@linaro.org; Russell King; Bhupesh
>> Sharma; netdev@vger.kernel.org; Joerg Roedel; Kumar Gala; linux-
>> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Yang-Leo Li;
>> iommu@lists.linux-foundation.org; Rob Herring; linux-i2c@vger.kernel.org;
>> Claudiu Manoil; Santosh Shilimkar; Xiaobo Xie; linux-clk@vger.kernel.org;
>> Qiang Zhao
>> Subject: RE: [v10, 7/7] mmc: sdhci-of-esdhc: fix host version for T4240-
>> R1.0-R2.0
>>
>> Hi Arnd,
>>
>> Any comments?
>> Please reply when you see the email since we want this eSDHC issue to be
>> fixed soon.
>>
>> All the patches are Freescale-specific and is to fix the eSDHC driver.
>> Could we let them merged first if you were talking about a new way of
>> abstracting getting SoC version.
>>
>>
>> Thanks :)
>>
>>
>> Best regards,
>> Yangbo Lu
>>
>
