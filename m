Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id E56D7DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 00:20:11 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1635838wag
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 05 Aug 2007 07:20:11 -0700 (PDT)
Message-ID: <fa686aa40708050720y3e96d8u14d793d2b850f615@mail.gmail.com>
Date: Sun, 5 Aug 2007 08:20:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "=?ISO-8859-1?Q?Joachim_F=F6rster?=" <mls.JOFT@gmx.de>
Subject: Re: ML403 / ALSA driver for AC97 Controller
In-Reply-To: <fa686aa40708050719l2cfcb507y26e39b3e067e543c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1185047879.15040.34.camel@localhost>
	<fa686aa40707211317q47b12a38jbe05e4d2c89767f4@mail.gmail.com>
	<1186300813.5534.33.camel@localhost>
	<fa686aa40708050719l2cfcb507y26e39b3e067e543c@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/5/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 8/5/07, Joachim F=F6rster <mls.JOFT@gmx.de> wrote:
> > tag v2.6.22 (Linus)
> > branch master (Linus)
> > branch virtex-dev (your v2.6.22 based branch)
> >
> > I had to make different patches, because one version didn't apply
> > cleanly to the other branches, due to differences in a Kconfig file e.g=
.
> > and above all in the virtex_devices.c file.
> >
> > Now, my question is: Which one should I post to the mailing list? (afte=
r
> > testing these patches - I haven't got a chance yet to test them on real
> > hardware - compilation is ok).
>
> Post the one against master, ultimately that's where the code needs to
> go.  I'll take care of any conflicts with my tree, and v2.6.22 is
> irrelevant (at least as far as getting things into mainline is
> concerned).  :-)
> >
> > One more thing: I made two parts, one patch adds the driver and the
> > other one makes the registration with the platform bus. Is this ok? (I
> > saw this scheme in your virtex-dev branch.)
>
> Absolutely!  Splitting it up into logical changes is the right way to do =
it.
>
> > Meanwhile, I had a _very_ short look into ASoC ... and I don't really
> > know ... My driver already uses the AC97 Layer of ALSA, so in some way
> > the codec is already separated from the controller. Xilinx' AC97
> > Controller Reference does have some very bad impact on the codec which
> > forced me to implement codec register shadowing ... hmmmm, I have to
> > look at it (ASoC) again - as soon as there is more (free)time ...
>
> Heh, okay.  I haven't dug into ASoC either, so I can't make too many comm=
ents.

One more thing; make sure you CC the ALSA list when you post.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
