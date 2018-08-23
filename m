Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wmzS26GyzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 11:29:24 +1000 (AEST)
Message-ID: <18175413a0148f7859ab36ed9715dce7a598f318.camel@kernel.crashing.org>
Subject: Re: DT case sensitivity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robh@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Grant Likely
 <grant.likely@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Kumar Gala
 <kumar.gala@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Frank
 Rowand <frowand.list@gmail.com>,
 devicetree-spec@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 23 Aug 2018 11:29:01 +1000
In-Reply-To: <CAL_JsqKqkO31ekVMFKs+osLvKdZyDzRowF1thWXn5=tWhrJgvw@mail.gmail.com>
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
 <CAL_JsqKqkO31ekVMFKs+osLvKdZyDzRowF1thWXn5=tWhrJgvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-08-22 at 20:26 -0500, Rob Herring wrote:
> On Wed, Aug 22, 2018 at 8:14 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > On Wed, 2018-08-22 at 19:47 -0500, Rob Herring wrote:
> > > The default DT string handling in the kernel is node names and
> > > compatibles are case insensitive and property names are case sensitive
> > > (Sparc is the the only variation and is opposite). It seems only PPC
> > > (and perhaps only Power Macs?) needs to support case insensitive
> > > comparisons. It was probably a mistake to follow PPC for new arches
> > > and we should have made everything case sensitive from the start. So I
> > > have a few questions for the DT historians. :)
> > 
> > Open Firmware itself is insensitive.
> 
> Doesn't it depend on the implementation? Otherwise, how is Sparc different?

Not sure ... Forth itself is insensitive for words but maybe not for
string comparisons.

> 
> > > What PPC systems are case insensitive? Can we limit that to certain systems?
> > 
> > All PowerMacs at least, the problem is that I don't have DT images or
> > access to all the historical systems (and yes some people occasionally
> > still use them) to properly test a change in that area.
> 
> I'm temped to break them so I can find folks to provide me with DT dumps. :)

I have a collection of DT dumps but I'm not sure about the legality of
publishing them...

Cheers,
Ben.
