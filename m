To: Dave Strout <dstrout@linuxfoundary.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Basics -- what tools for Walnut? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 05 Jun 2002 13:36:58 EDT."
             <3CFE4C3A.4070604@linuxfoundary.com>
Date: Wed, 05 Jun 2002 21:16:33 +0200
Message-Id: <20020605191638.298B0102F2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CFE4C3A.4070604@linuxfoundary.com> you wrote:
>
> I think I'm missing a basic concept here -- I'm about to do some work on
> a Walnut system, so  I started by loading up the HardHat Linux that came
> with the Walnut onto my intel desktop, then grabbing the
> linuxppc_2_4_devel kernel via rsync.  When I try to compile, gas startes
> to complain about "unknown option '-m405'".
...
> So, is there a patch I should be applying before building the
> cross-compile environment, or a specific set of tools somewhere, or what
> am I missing?

Have a look at our ELDK, see http://www.denx.de/ELDK/

We support a couple of 405 boards (although the walnut is not one  of
those).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Faith: not *wanting* to know what is true."    - Friedrich Nietzsche

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
