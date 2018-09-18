Return-Path: <frowand.list@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FDbP2gd2zF3JS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 06:09:04 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id 205-v6so614178pgd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 13:09:04 -0700 (PDT)
Subject: Re: [PATCH 3/3] scripts/dtc: Update to upstream version
 v1.4.7-14-gc86da84d30e4
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180913202828.15372-1-robh@kernel.org>
 <20180913202828.15372-3-robh@kernel.org>
 <f9684222-fae0-c305-d48a-be77ebb985a3@gmail.com>
 <CAL_JsqLTcLVGCmjTMi8GojomP=VbFQ5EqKcGnOPo=Wwh5Lc_mw@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <6414499d-2261-ef50-617e-a743173a3041@gmail.com>
Date: Tue, 18 Sep 2018 13:09:00 -0700
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLTcLVGCmjTMi8GojomP=VbFQ5EqKcGnOPo=Wwh5Lc_mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/18/18 11:55, Rob Herring wrote:
> On Fri, Sep 14, 2018 at 2:32 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 09/13/18 13:28, Rob Herring wrote:
>>> Major changes are I2C and SPI bus checks, YAML output format (for
>>> future validation), some new libfdt functions, and more libfdt
>>> validation of dtbs.
>>>
>>> The YAML addition adds an optional dependency on libyaml. pkg-config is
>>> used to test for it and pkg-config became a kconfig dependency in 4.18.
>>
>> For Ubuntu, the libyaml dependency is provided by the packages:
>>
>>    libyaml-0-2
>>    libyaml-dev
> 
> Yes, but as it is not yet required by anything in the kernel I don't
> think that needs to be documented yet. Also, offhand, I don't think we
> generally document in the kernel distro specifics like package names.
> 
> Rob
> 

Agreed.  I was providing information that might save other people a bit
of research.  It is sufficiently visible in the email thread and does
not need to be in the commit message.
