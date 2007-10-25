Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 4F48BDDE9B
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 00:21:29 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so694189wag
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 07:21:27 -0700 (PDT)
Message-ID: <fa686aa40710250721m54dda956qe7c8986416d0dfa2@mail.gmail.com>
Date: Thu, 25 Oct 2007 08:21:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Valentine Barshak" <vbarshak@ru.mvista.com>
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
In-Reply-To: <47208273.8050601@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071024163412.GA17785@ru.mvista.com>
	<471FC191.6020704@genesi-usa.com>
	<200710241850.05467.david-b@pacbell.net>
	<fa686aa40710241941w16fe3e75hb8ede9f9c8464e94@mail.gmail.com>
	<47208273.8050601@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/25/07, Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> Grant Likely wrote:
> > On 10/24/07, David Brownell <david-b@pacbell.net> wrote:
> >> On Wednesday 24 October 2007, Matt Sealey wrote:
> >>> Can we just make sure real quickly that the changing of compatibles
> >>> doesn't break existing, not-easily-flashable firmwares?
> >> Yeah, I'm not keen on such breakage either...
> >
> > Add my voice to the chorus.  It's okay to change the binding, but make
> > sure the old binding is still supported.
> >
> > Cheers,
> > g.
> >
>
> Actually, I thought that changing the DTS stuff for mpc52xx boards would
> suffice. Sorry, I was unaware of Efika firmware here. I'll keep old
> bindings as well.

Even if that were the case; I'm nervous about breaking compatibility
with old device trees.

We probably need a formal guideline here.  ie. When is it okay to drop
compatibility with old dts files?

> Does the device tree have "ohci-bigendian" or "ohci-be" compatible
> property on Efika?

If it doesn't, it can be added during prom_init.c  We're already doing
a bunch of efika fixups there anyway.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
