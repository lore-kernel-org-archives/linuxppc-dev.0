From: "Dustin Byford" <dustin@firein.net>
Subject: Re: custom mpc8240 student project (long)
To: "Ron Bianco" <ronb@junction.net>,
	<linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 21 Feb 2002 20:07:16 -0500
Message-ID: <web-8960974@zipmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you all for the suggestions.  The BDI was simply too
 much for the school to spend on a small group of people.
  I did however contact Macraigor Systems and explain my
 situation.  They have donated a wiggler so it looks like
 I'm in business, thanks to Macraigor!

On Thu, 21 Feb 2002 14:40:05 -0800
 "Ron Bianco" <ronb@junction.net> wrote:
>
> My $.02:
>
> Why don't you just use a regular old EPROM to hold your
>  ppcboot monitor image.?

Haven't quite decided on the ROM exactly, still waiting on
 samples from AMD but a regular EPROM sounds like good idea
 for now.

> You're planning to run at a very low clock speed on your
>  wire-wrapped board.
> Ugh!
> Better check the 8240 datasheet, there may be lower
>  limits to what's allowed.

>From the hardware spec it looks like the PLL can be
 configured to 33Mhz/pci 33mhz/memory 100Mhz cpu.
  Hopefully the wirewrap can handle this.

>
> Good luck, Ron

It is starting to sound like I'm really going to need luck,
 so thanks.


     --Dustin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
