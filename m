Message-ID: <38469B36.15EBF10D@eecs.lehigh.edu>
Date: Thu, 02 Dec 1999 11:15:50 -0500
From: Jason Kim <jwk2@eecs.lehigh.edu>
MIME-Version: 1.0
To: Kevin Buettner <kev@primenet.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Richard Henderson <rth@cygnus.com>,
        "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
Subject: Re: patch for problem with va-ppc.h included with egcs and gcc-2.95.2
References: <4.2.2.19991130110534.00b563b0@mail.lauterbach.com>
		<4.2.2.19991201162019.03c111b0@mail.lauterbach.com>
		<384574A2.A003F5F6@eecs.lehigh.edu>
		<99120114490800.04790@localhost.localdomain>
		<38460186.8CEC249C@eecs.lehigh.edu> <991202072719.ZM11771@saguaro.lan>
Content-Type: text/plain; charset=iso-2022-kr
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin Buettner wrote:

> How about anything that calls vprintf, vsprintf, or vsnprintf?

Works with my patches. no probs.  

> A more concrete example: Suppose you've compiled the perl library
> to use the old interface and then compile an application which
> uses it with your va_list interface.  Then suppose the application
> calls sv_vsetpvfn() in the perl library.  Would it work?

I'll try this as soon as I hack up some src to test it (sometime today, 
hopefully). 

(crossed fingers??)

-jason.

> 
> I feel like I'm playing devil's advocate here because I would really
> like it if you (or someone) could straighten out the ppc va_list
> issues.  I've been bitten by problems similar to the ones that you've
> encountered more than once over the years.  Recently I had to fix a
> problem in gdb where it would've been nice to do a va_list copy.
> Instead, I restructured the code so that a copy wasn't necessary.  It
> turned out to be doable in this instance, but I'm aware of some code
> in libiberty that can't be restructured so easily.  (But for some
> reason, it seems to be working now on linux/ppc.  I remember a time
> when it didn't.)
> 
> Kevin
> 
> --
> Kevin Buettner
> kev@primenet.com, kevinb@cygnus.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
