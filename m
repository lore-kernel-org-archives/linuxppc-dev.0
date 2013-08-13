Return-Path: <festevam@gmail.com>
Received: from mail-vc0-x22f.google.com (mail-vc0-x22f.google.com
 [IPv6:2607:f8b0:400c:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4AB542C015A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 05:01:20 +1000 (EST)
Received: by mail-vc0-f175.google.com with SMTP id ia10so4157472vcb.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 12:01:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
Date: Tue, 13 Aug 2013 16:01:14 -0300
Message-ID: <CAOMZO5AqUcKYD8Rx_NV5=r3soBaScDY5PxD0SS_HEyYpf_PpbQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
From: Fabio Estevam <festevam@gmail.com>
To: Nicolin Chen <b42378@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org,
 p.zabel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 13, 2013 at 2:58 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Aug 12, 2013 at 9:01 AM, Nicolin Chen <b42378@freescale.com> wrote:
>> +Required properties:
>> +
>> +  - compatible : Compatible list, contains "fsl,<chip>-spdif". Using general
>
> Can't we just use "fsl,fsl-spdif" instead?

Or maybe "fsl,imx35-spdif", since mx35 was the first imx SoC with this
spdif IP block.
