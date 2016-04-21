Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrTW113CNzDqfD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 05:35:41 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 1A85B20303
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 19:35:39 +0000 (UTC)
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com
 [209.85.161.172])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EA0272034A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 19:35:35 +0000 (UTC)
Received: by mail-yw0-f172.google.com with SMTP id o66so100423699ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 12:35:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+JO41w2PweW0n1Z78=wPnYh+wfa==Hb8o37L3ynDndkA@mail.gmail.com>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <CAL_Jsq+JO41w2PweW0n1Z78=wPnYh+wfa==Hb8o37L3ynDndkA@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 21 Apr 2016 14:35:15 -0500
Message-ID: <CAL_JsqLr+vS4BB9qvkrbg93Ypm8yhzs6eqESQFpjkL5_fv+jkw@mail.gmail.com>
Subject: Re: [PATCH 00/14] DT: Fix spelling of standard properties
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2016 at 6:58 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Wed, Apr 20, 2016 at 10:32 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>>         Hi all,
>>
>> This patch series fixes misspellings of various standard DT properties
>> in DT binding documentation, DTS files, and error messages.
>> While most of these are harmless, some of them may cause hard-to-debug
>> failures.
>>
>> Please apply where appropriate.
>
> I'll happily take the whole series if you like, though I've not
> reviewed it all yet.

Now, I have. Other than patch 4 and 14, for the series:

Acked-by: Rob Herring <robh@kernel.org>

Rob
