To: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
Cc: "'VanBaren, Gerald (AGRE)'" <Gerald.VanBaren@smiths-aerospace.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question on the fs choice 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 May 2004 20:00:01 CDT."
             <EFB813091B18D511BD3600508B644F820A617EC3@tx14exm06.ftw.mot.com>
Date: Thu, 13 May 2004 10:09:26 +0200
Message-Id: <20040513080931.71C3FC108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Adam,

in message <EFB813091B18D511BD3600508B644F820A617EC3@tx14exm06.ftw.mot.com> you wrote:
>
> I've contacted SanDisk regarding their warranty of surviving a power
> shortage in the middle of a write-cycle and received a document explaining
> the expected behavior.
...
> These particular SanDisk cards are equipped with an enhanced version of the
> internal controller that is capable of surviving such scenario leaving the
> card in a robust state.
...
> One of the recommendations was to implement a 100 millisecond power back-up
> provided for the card to finish its internal write cycle. Of course, this

There may even be CF cards with integrated coldcap - at least  that's
what I've been told once.

> To cut the long story short I personally believe (based on the number of
> stress tests we perform on our target platforms) that modern compact flash
> cards (e.g. SDCFB-xx-201 series) can be safely used as a main storage medium
> for commercial applications.

Be careful here. The fact that one manufacturer gives you a  warranty
for some specific types of flash cards does not mean that all "modern
compact  flash  cards"  behave identically. You will need to ask each
vendor for such a warranty for the specific cards you  are  going  to
use.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Voodoo Programming: Things programmers do that  they  know  shouldn't
work  but they try anyway, and which sometimes actually work, such as
recompiling everything.                             - Karl Lehenbauer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
