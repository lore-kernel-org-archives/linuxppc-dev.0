Return-Path: <glikely@secretlab.ca>
Received: from mail-ee0-f43.google.com (mail-ee0-f43.google.com [74.125.83.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDC882C008A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 02:18:33 +1000 (EST)
Received: by mail-ee0-f43.google.com with SMTP id l10so891090eei.30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jul 2013 09:18:29 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] of: Fix address decoding on Bimini and js2x machines
To: Rob Herring <robherring2@gmail.com>
In-Reply-To: <CACxGe6ucVocguyNdZ9CiN0ef=WgmOrZe0FyVij_bC7bJZe41=g@mail.gmail.com>
References: <1372831270.4122.36.camel@pasglop> <51D430C7.8030100@gmail.com>
 <CACxGe6ucVocguyNdZ9CiN0ef=WgmOrZe0FyVij_bC7bJZe41=g@mail.gmail.com>
Date: Thu, 04 Jul 2013 17:18:28 +0100
Message-Id: <20130704161828.EB08D3E08D0@localhost>
Cc: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 3 Jul 2013 15:37:56 +0100, Grant Likely <grant.likely@linaro.org> wrote:
> On Wed, Jul 3, 2013 at 3:10 PM, Rob Herring <robherring2@gmail.com> wrote:
> > On 07/03/2013 01:01 AM, Benjamin Herrenschmidt wrote:
> >>  Commit:
> >>
> >>   e38c0a1fbc5803cbacdaac0557c70ac8ca5152e7
> >>   of/address: Handle #address-cells > 2 specially
> >>
> >> broke real time clock access on Bimini, js2x, and similar powerpc
> >> machines using the "maple" platform. That code was indirectly relying
> >> on the old (broken) behaviour of the translation for the hypertransport
> >> to ISA bridge.
> >>
> >> This fixes it by treating hypertransport as a PCI bus
> >>
> >> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> CC: <stable@vger.kernel.org> [v3.6+]
> >> ---
> >>
> >> Rob, if you have no objection I will put that in powerpc -next
> >
> > NP.
> >
> > Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> I'll include this in my 3.11 pull request for Linus

Oops. Ben, I misread what you wrote. It would have been just fine to
include it in your powerpc -next branch. Sorry for the confusion.

Anyway, I saw your powerpc pull req and that this patch wasn't in it, so
I've picked it up and will send it to Linus as soon as the test build
completes.

g.
