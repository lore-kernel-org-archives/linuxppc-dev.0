Subject: Re: Lite5200 PCI not working
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <40D70AE3.8070408@iti.fi>
References: <40D70AE3.8070408@iti.fi>
Content-Type: text/plain
Message-Id: <1088671264.6226.59.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Thu, 01 Jul 2004 10:41:05 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-21 at 18:20, Kate Alhola wrote:
> >Are you really sure? Maybe it was just an issue of finding the  right
> >jumper  settings (which is non-trivial). We tested both with Rev. 4.0
> >and Rev. 5.0 cards, and didn't need -12V.

Hi,

seems I'm also stuck with this non-trivial problem here.
I have a Rev.5 card, and just discovered the three jumpers
to override the analog MUX (J250-252).

I get a picture now, but it's *very* dim, and the colors
seem not quite right when the CRT's brightness is .

Are there any more jumpers to set or could this be an
issue with the driver (linuxppc_2_4_devel -Dyesterday)?
Or maybe is the MUXer also a neccessary booster?

--
Stefan Nickl
Kontron Modular Computers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
