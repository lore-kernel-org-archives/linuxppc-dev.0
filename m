Return-Path: <mturquette@baylibre.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 540BE1A074C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 21:11:24 +1100 (AEDT)
Received: by pabrc13 with SMTP id rc13so83203251pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 03:11:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, 
From: Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <1444435064.5185.16.camel@freescale.com>
Cc: "Stephen Boyd" <sboyd@codeaurora.org>,
 "Tang Yuantian" <Yuantian.Tang@freescale.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "Liberman Igal-B31950" <Igal.Liberman@freescale.com>,
 "Bucur Madalin-Cristian-B32716" <madalin.bucur@freescale.com>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
 <20150811182535.31346.52965@quantum>
 <1443745589.5336.185.camel@freescale.com>
 <1444435064.5185.16.camel@freescale.com>
Message-ID: <20151022101116.20687.55089@quantum>
Subject: Re: [RFC PATCH 0/8] clk: qoriq: Move chip-specific knowledge into
 driver
Date: Thu, 22 Oct 2015 03:11:16 -0700
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Scott Wood (2015-10-09 16:57:44)
> On Thu, 2015-10-01 at 19:26 -0500, Scott Wood wrote:
> > [Resending to updated e-mail address]
> > =

> > On Tue, 2015-08-11 at 11:25 -0700, Michael Turquette wrote:
> > > Hi Scott,
> > > =

> > > Quoting Scott Wood (2015-06-18 19:49:10)
> > > > The existing device tree bindings are error-prone and inflexible. =

> > > > Correct the mistake by moving the knowledge into the driver, which
> > > > has more flexibility in describing the quirks of each chip.  This l=
eaves
> > > > the device tree to its proper role of identifying a programming =

> > > > interface
> > > > rather than describing its individual registers.
> > > =

> > > Sorry for not responding to this one sooner. Fell through the cracks.
> > > =

> > > All of the changes to drives/clk/clk-qoriq.c look great to me. I assu=
me
> > > you need to keep all of these patches together and want to the take
> > > through the freescale tree? If so feel free to add,
> > > =

> > > Acked-by: Michael Turquette <mturquette@baylibre.com>
> > =

> > Is the ack still valid for the v3 patchset?

Yes. Looks Stephen beat me to it though.

Regards,
Mike

> =

> ping
> =

> -Scott
>=20
