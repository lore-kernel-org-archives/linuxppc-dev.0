Subject: Re: Lite5200 PCI not working
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040708124140.E18E4C109F@atlas.denx.de>
References: <20040708124140.E18E4C109F@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1089293675.6002.100.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Thu, 08 Jul 2004 15:34:35 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-07-08 at 14:41, Wolfgang Denk wrote:
> In message <1089289959.5996.66.camel@lucy.pep-kaufbeuren.de> you wrote:
> >
> > For the kernel, I use what's in your CVS:
> > linuxppc_2_4_devel/drivers/video/mb86290
> >
> > mb86290fb.c is at rev. 1.2
>
> Should be fine.
>
> > The hardware and kernel are different, I'm using our homegrown
> > EB8540 module on a EBC1 carrier board (in shops soon ;), which
> > has a standard PCI slot to fit the Coral-P card.
>
> Is this a 3.3V or a 5V PCI slot? I think there  is  some  3.3V  power
> supply jumper on the Coral-P card - you may want to check this.

The carrier is configured for 3.3V.

J52 is closed
JP150 is 2-3

The output muxer is bypassed (+PDN EN) since there is no -12V.
The voltage at JP150 2-3 is 3.265V.


Btw, I've just heard that Fujitsu seems to have cancelled the
low-cost successor of the Coral-P, the Lime. Bad news for us here :(

--
Stefan Nickl
Kontron Modular Computers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
