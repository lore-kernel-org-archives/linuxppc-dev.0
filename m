To: Stefan Nickl <Stefan.Nickl@kontron.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lite5200 PCI not working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Jul 2004 10:52:56 +0200."
Date: Thu, 01 Jul 2004 11:18:53 +0200
Message-Id: <20040701091858.A3564C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1088671264.6226.59.camel@lucy.pep-kaufbeuren.de> Stefan Nickl wrote:
> On Mon, 2004-06-21 at 18:20, Kate Alhola wrote:
> > >Are you really sure? Maybe it was just an issue of finding the  right
> > >jumper  settings (which is non-trivial). We tested both with Rev. 4.0
> > >and Rev. 5.0 cards, and didn't need -12V.
...
> seems I'm also stuck with this non-trivial problem here.
> I have a Rev.5 card, and just discovered the three jumpers
> to override the analog MUX (J250-252).
>
> I get a picture now, but it's *very* dim, and the colors
> seem not quite right when the CRT's brightness is .
>
> Are there any more jumpers to set or could this be an
> issue with the driver (linuxppc_2_4_devel -Dyesterday)?
> Or maybe is the MUXer also a neccessary booster?

I've updated the table to include  the  settings  for  the  Rev.  4.0
board, too, and to list ALL jumpers on the board.

> OK. Please see http://www.denx.de/twiki/bin/view/DULG/CoralPInstallation

Hope this helps.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
America has been discovered before, but it has always been hushed up.
- Oscar Wilde

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
