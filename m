Message-ID: <XFMail.20030115122832.medp@primag.co.uk>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20030115113838.GB23564@zax>
Date: Wed, 15 Jan 2003 12:28:32 -0000 (GMT)
From: Mark Powell <medp@primag.co.uk>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Assistance with using /dev/fb0 and No X windows
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 15-Jan-2003 David Gibson wrote:
>  Indeed..  however I did find that the folks from Silicon Motion seemed
>  to be reasonably willing to help with finding the necessary frobbing
>  to do.

we had mixed response, but had to find the key regs ourselves.

>
>  I'm a bit surprised that lynxfb.c plus XFree wasn't enough to work for
>  you (well, after modifying the Icebox specific parts), but it was
>  pretty flaky, so I'm not all that surprised.  From memory, it
>  shouldn't be a really big job to make lynxfb.c a bit more solid, and
>  even make it work as a proper kernel framebuffer driver, but it worked
>  enough for my purposes so I never got around to it (plus that would
>  have meant figuring out the baroque intricacies of the fbdev
>  interface).

FWIW I have a flaky fb-based console driver for the Lynx3DM. It works as far as
running the X server, but doesn't restore correctly when X exits. Virtual
terminals work on it. There are a few specifics to our card in it, but you're
welcome to it as it stands.
I am planning to make PPCBoot put the Lynx3DM into a basic VGA mode and then
try the linux generic VGA driver. Comments any one?

Mark

--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, medp@primagraphics.co.uk,
http://www.primagraphics.co.uk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
