Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A55E1A01DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 10:33:46 +1100 (AEDT)
Message-ID: <1449444825.23526.1.camel@ellerman.id.au>
Subject: Re: [PATCH] of: Fix comparison of reserved memory regions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Grant Likely <grant.likely@linaro.org>, Mitchel Humpherys
 <mitchelh@codeaurora.org>
Date: Mon, 07 Dec 2015 10:33:45 +1100
In-Reply-To: <CAL_Jsq+PBXGwJC36Hio5KRU7rPSb-FRDZv-rAozg-sL8iCgWHA@mail.gmail.com>
References: <1447843598-9355-1-git-send-email-mpe@ellerman.id.au>
 <vnkwk2oum9b8.fsf@codeaurora.org>
 <5CD6EBAA-D0D6-434A-B9EA-B144C05711BC@ellerman.id.au>
 <CAL_Jsq+PBXGwJC36Hio5KRU7rPSb-FRDZv-rAozg-sL8iCgWHA@mail.gmail.com>
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

On Sun, 2015-12-06 at 14:31 -0600, Rob Herring wrote:
> On Sat, Dec 5, 2015 at 5:43 AM, Michael Ellerman <michael@ellerman.id.au> wrote:
> > On 5 December 2015 04:07:39 GMT+11:00, Mitchel Humpherys <mitchelh@codeaurora.org> wrote:
> > > On Wed, Nov 18 2015 at 09:46:38 PM, Michael Ellerman
> > > <mpe@ellerman.id.au> wrote:
> > > > Fix it by just doing the standard double if and return 0 logic.
> > > > 
> > > > Fixes: ae1add247bf8 ("of: Check for overlap in reserved memory
> > > regions")
> > > 
> > > Woops, thanks.
> > > 
> > > Tested-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> > 
> > Thanks for testing.
> > 
> > Rob, can we get this merged for 4.4 please?
> 
> Yes. I meant to last week, but was waiting on getting another issue
> sorted out. I should get it to Linus in the next couple of days.

Sure thing. No great rush but would be nice for it to be fixed before 4.4
releases.

cheers
