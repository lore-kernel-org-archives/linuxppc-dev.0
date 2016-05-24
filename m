Return-Path: <linus.walleij@linaro.org>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDYT16wtKzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 21:43:32 +1000 (AEST)
Received: by mail-oi0-x232.google.com with SMTP id j1so21394256oih.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 04:43:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160516165618.GA29776@rob-hp-laptop>
References: <c7b118c342c161954126e2e82cf1a0a6a127b4c2.1463002267.git.chunkeey@googlemail.com>
 <20160516152746.GA13649@rob-hp-laptop>
 <20160516165618.GA29776@rob-hp-laptop>
Date: Tue, 24 May 2016 13:43:29 +0200
Message-ID: <CACRpkdb2o3b3jN2de7qMmaPmtYK2QArQeHuhQrQgGb8p284T=Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: dt-bindings: add ibm,ppc4xx-gpio binding
From: Linus Walleij <linus.walleij@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Kumar Gala <galak@codeaurora.org>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Mark Rutland <mark.rutland@arm.com>,
 Pawel Moll <pawel.moll@arm.com>, Alexandre Courbot <gnurou@gmail.com>,
 Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 16, 2016 at 6:56 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, May 16, 2016 at 10:27:46AM -0500, Rob Herring wrote:
>> On Thu, May 12, 2016 at 12:07:48AM +0200, Christian Lamparter wrote:

>> > This patch adds binding information for IBM/AMCC/APM GPIO
>> > Controllers of the PowerPC 4XX series and compatible SoCs.
(...)
>> Acked-by: Rob Herring <robh@kernel.org>
>
> As this is just a binding doc, I've applied it.

OK less work on my part :)
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
