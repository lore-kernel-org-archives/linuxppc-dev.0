To: Stefan Nickl <Stefan.Nickl@kontron.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lite5200 PCI not working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Jul 2004 10:41:05 +0200."
             <1088671264.6226.59.camel@lucy.pep-kaufbeuren.de>
Date: Thu, 01 Jul 2004 10:52:56 +0200
Message-Id: <20040701085301.3741AC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1088671264.6226.59.camel@lucy.pep-kaufbeuren.de> you wrote:
> On Mon, 2004-06-21 at 18:20, Kate Alhola wrote:
> > >Are you really sure? Maybe it was just an issue of finding the  right
> > >jumper  settings (which is non-trivial). We tested both with Rev. 4.0
> > >and Rev. 5.0 cards, and didn't need -12V.
>
> Hi,
>
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

OK. Please see http://www.denx.de/twiki/bin/view/DULG/CoralPInstallation

It includes two images (for Rev. 4.0 and Rev. 5.0 cards)  taken  from
working systems.

I'll need to update the table to represent the differences.

Hope this gets you started.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Newer disks don't have a rectangular layout anymore,  but  Unix  (and
SunOS) still assumes this.     - Peter Koch in <koch.779356598@rhein>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
