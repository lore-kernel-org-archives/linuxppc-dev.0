Message-ID: <39255738.272281F4@motorola.com>
Date: Fri, 19 May 2000 10:01:12 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"  <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com> <391C3945.9E0A439F@charter.net> <391C5416.15ADA181@motorola.com> <391D5E99.D14A02F2@charter.net> <39201DD2.2135361E@motorola.com> <39202D2C.385DD3B@charter.net> <3920AA9F.2DCA0B2E@charter.net> <3920ED16.A2D26629@snom.de> <3921B844.572E3C63@charter.net> <3922046E.D77E156@charter.net> <3922EE48.1E41DA1B@motorola.com> <3923618A.F4D70742@charter.net> <39241726.1CC6B342@motorola.com> <392521B2.5ACFBD8F@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dan A. Dickey" wrote:
>
> > Um, that's documented so I take no blame for it. :)
> > See page 20-41.  If you have debug mode enabled, and
> > are not currently IN debug mode (ie, MPC8bug is connected,
> > but you are running your code), then a write to the
> > DP registers is ignored.
>
> Page 20-41 of what?  There's nothing like that in my
> 850 users manual, and the mpc8bug users manual doesn't
> come close to having 20 chapters.
>
Oooooh, you're one of those Netcomm customers. :)  I currently
support the MPC823/MPC823e.  They're very similar chips. Our
manual is slightly different from the Netcomm manual.  The
chapter in question is the Development Capabilities chapter.
I don't have an MPC850 manual handy.  Besides, ours is much
better. :)

BTW, the final version of the MPC823/MPC823e manual is now
availible on our website.  A printed version should be availible
at the LDC in a few weeks.  The Powers That Be are making us change
the cover from the spiffy one we have to a black Digital DNA one.
Feh.

--
MPC823 Applications Engineering Development
Get help from other MPC823 customers on the
comp.sys.powerpc.tech newsgroup!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
