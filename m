Message-ID: <XFMail.000728162326.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20000728083426.19235@mailhost.mipsys.com>
Date: Fri, 28 Jul 2000 16:23:26 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Stealth port problems
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Hi!  I have troubles with my stealth port on a G3-blue. When it runs at
> 115200
>>ifconfig
>>shows a lot of overruns. At 57600 it works fine, but it's slow :-((
>>
>>Does any of you own that serial port ?  Suggestions ??
>
> Which kernel ?

2.2.16p (usb patches)

> With the DMA serial driver, it should work better than
> that... The Stealth hardware is probaly not responsible, it's just a line
> driver plugged instead of the modem, the actual zilog SCC is part of
> Apple's ASIC.

I just discovered a strange thing... It seems to work fine in console, but when
X is running it doesn't.  (??)


Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
