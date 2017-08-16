Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXffb3SNdzDqYN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 05:33:59 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id e124so4467507oig.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 12:33:59 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAL_JsqLYz9ACd-YAtU0gEHkY8A++cCeBTW9jvUyc5OheEq4scQ@mail.gmail.com>
References: <20170718214339.7774-49-robh@kernel.org>
 <CAL_JsqLYz9ACd-YAtU0gEHkY8A++cCeBTW9jvUyc5OheEq4scQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Aug 2017 21:33:56 +0200
Message-ID: <CAK8P3a3eEV8KWb-cCovRH0LQQ+88yJ7R9se1sjd06K_TyPzKjQ@mail.gmail.com>
Subject: Re: [PATCH] soc: Convert to using %pOF instead of full_name
To: Rob Herring <robh@kernel.org>
Cc: "arm@kernel.org" <arm@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Scott Wood <oss@buserror.net>,
 Qiang Zhao <qiang.zhao@nxp.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
 "open list:MEDIA DRIVERS FOR RENESAS - FCP"
 <linux-renesas-soc@vger.kernel.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 10, 2017 at 12:09 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jul 18, 2017 at 4:43 PM, Rob Herring <robh@kernel.org> wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Scott Wood <oss@buserror.net>
>> Cc: Qiang Zhao <qiang.zhao@nxp.com>
>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>

> Arnd, Olof,
>
> Can you please apply this one.

Applied to next/drivers with the various Acks, thanks!

      Arnd
