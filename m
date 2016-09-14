Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZ6js1dYHzDsW5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 02:40:49 +1000 (AEST)
Received: by mail-wm0-x230.google.com with SMTP id i130so58166090wmf.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 09:40:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160608195241.GA6805@rob-hp-laptop>
References: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
 <20160608195241.GA6805@rob-hp-laptop>
From: Leo Li <pku.leo@gmail.com>
Date: Wed, 14 Sep 2016 11:40:46 -0500
Message-ID: <CADRPPNQ+hikr1qNK1wPbLnhudUrU1bN_2iuYyRQnqCN4Zwh83Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
To: Rob Herring <robh@kernel.org>, rui.zhang@intel.com
Cc: Jia Hongtao <hongtao.jia@nxp.com>, devicetree@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>, Scott Wood <scott.wood@nxp.com>,
 Eduardo Valentin <edubezval@gmail.com>, Kumar Gala <galak@codeaurora.org>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 8, 2016 at 2:52 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jun 07, 2016 at 11:27:34AM +0800, Jia Hongtao wrote:
>> For different types of SoC the sensor id and endianness may vary.
>> "#thermal-sensor-cells" is used to provide sensor id information.
>> "little-endian" property is to tell the endianness of TMU.
>>
>> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
>> ---
>> Changes for V2:
>> * Remove formatting chnages.
>>
>>  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>
> Acked-by: Rob Herring <robh@kernel.org>

Hi Zhang Rui,

Since you have applied the driver patch, can you also apply the
binding patch?  The binding is supposed to go with the driver.

Regards,
Leo
