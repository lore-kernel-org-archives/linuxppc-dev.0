Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id 7FAB2DDF07
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 04:10:15 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so494557rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 11:10:14 -0700 (PDT)
Message-ID: <fa686aa40809251110t1493e74bucd142f10c242f004@mail.gmail.com>
Date: Thu, 25 Sep 2008 12:10:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [RFC] GPIO-Watchdog in devicetree
In-Reply-To: <20080925175907.GA4747@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080922194357.GA32041@pengutronix.de>
	<20080923150256.GC13593@secretlab.ca>
	<20080925175907.GA4747@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 11:59 AM, Scott Wood <scottwood@freescale.com> wrote:
>
> On Tue, Sep 23, 2008 at 09:02:56AM -0600, Grant Likely wrote:
> > For example:
> > / {
> >       model = "pengutronix,super-sexy-board";
> >       #address-cells = <1>;
> >       #size-cells = <1>;
> >       super-sexy-board,watchdog-gpio = <&gpio_simple 19 0>;
> >       ...
> > }
>
> Why as a property of the root node, and not as a node with a very
> specific compatible property?

Because the root node is the only logical board-level node we have
right now.  However, I'm not deeply committed to this approach.  The
only question I have about putting it in another node is choosing the
parent node.  I don't think it fits to make it a child of the SoC node
or any other bus node.

g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
