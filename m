Message-ID: <39236203.7B16C520@charter.net>
Date: Wed, 17 May 2000 22:22:43 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Richard Hendricks <richard.hendricks@motorola.com>,
        Nicolas-Peter Pohland <pohland@snom.de>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com> <391C3945.9E0A439F@charter.net> <391C5416.15ADA181@motorola.com> <391D5E99.D14A02F2@charter.net> <39201DD2.2135361E@motorola.com> <39202D2C.385DD3B@charter.net> <3920AA9F.2DCA0B2E@charter.net> <3920ED16.A2D26629@snom.de> <3921B844.572E3C63@charter.net> <3922046E.D77E156@charter.net> <3922EE48.1E41DA1B@motorola.com> <39236178.53CD635@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Richard Hendricks wrote:
>
> > Interesting.  So clearing the SYPCR early in the ROM code is what
> > was preventing you from getting the code to run stand-alone?
>
> Oh, yes.  Clearing SYPCR is a very bad thing.  You end up with counter
> values set to zero and immediately time out.  It seems a little strange,
> as you have also cleared the enable flags.  I am sure someone at SPS
> could explain the transistors flipping inside the part to make this
> happen.

Ok ok...not *clearing* SYPCR.  :)

Just setting it to 0xFFFFFF88.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
