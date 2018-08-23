Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wmwL5DmvzF2FR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 11:26:42 +1000 (AEST)
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com
 [209.85.216.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7081420C09
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 01:26:40 +0000 (UTC)
Received: by mail-qt0-f179.google.com with SMTP id r13-v6so4474725qtr.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 18:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
In-Reply-To: <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 22 Aug 2018 20:26:28 -0500
Message-ID: <CAL_JsqKqkO31ekVMFKs+osLvKdZyDzRowF1thWXn5=tWhrJgvw@mail.gmail.com>
Subject: Re: DT case sensitivity
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Grant Likely <grant.likely@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Kumar Gala <kumar.gala@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Frank Rowand <frowand.list@gmail.com>,
 devicetree-spec@vger.kernel.org, devicetree@vger.kernel.org,
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

On Wed, Aug 22, 2018 at 8:14 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2018-08-22 at 19:47 -0500, Rob Herring wrote:
> > The default DT string handling in the kernel is node names and
> > compatibles are case insensitive and property names are case sensitive
> > (Sparc is the the only variation and is opposite). It seems only PPC
> > (and perhaps only Power Macs?) needs to support case insensitive
> > comparisons. It was probably a mistake to follow PPC for new arches
> > and we should have made everything case sensitive from the start. So I
> > have a few questions for the DT historians. :)
>
> Open Firmware itself is insensitive.

Doesn't it depend on the implementation? Otherwise, how is Sparc different?

> > What PPC systems are case insensitive? Can we limit that to certain systems?
>
> All PowerMacs at least, the problem is that I don't have DT images or
> access to all the historical systems (and yes some people occasionally
> still use them) to properly test a change in that area.

I'm temped to break them so I can find folks to provide me with DT dumps. :)

Rob
