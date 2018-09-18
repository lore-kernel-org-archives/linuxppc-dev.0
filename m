Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FByJ3MQxzF3J9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:55:19 +1000 (AEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D05542150E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 18:55:16 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id b19-v6so1619660qkc.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 11:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180913202828.15372-1-robh@kernel.org>
 <20180913202828.15372-3-robh@kernel.org>
 <f9684222-fae0-c305-d48a-be77ebb985a3@gmail.com>
In-Reply-To: <f9684222-fae0-c305-d48a-be77ebb985a3@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Sep 2018 11:55:04 -0700
Message-ID: <CAL_JsqLTcLVGCmjTMi8GojomP=VbFQ5EqKcGnOPo=Wwh5Lc_mw@mail.gmail.com>
Subject: Re: [PATCH 3/3] scripts/dtc: Update to upstream version
 v1.4.7-14-gc86da84d30e4
To: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2018 at 2:32 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 09/13/18 13:28, Rob Herring wrote:
> > Major changes are I2C and SPI bus checks, YAML output format (for
> > future validation), some new libfdt functions, and more libfdt
> > validation of dtbs.
> >
> > The YAML addition adds an optional dependency on libyaml. pkg-config is
> > used to test for it and pkg-config became a kconfig dependency in 4.18.
>
> For Ubuntu, the libyaml dependency is provided by the packages:
>
>    libyaml-0-2
>    libyaml-dev

Yes, but as it is not yet required by anything in the kernel I don't
think that needs to be documented yet. Also, offhand, I don't think we
generally document in the kernel distro specifics like package names.

Rob
