Message-ID: <398426BC.67FCDC6E@denise.shiny.it>
Date: Sun, 30 Jul 2000 08:59:40 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Stealth port problems
References: <39811B2C.4D34DDD@denise.shiny.it> <20000728083426.19235@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Hi!  I have troubles with my stealth port on a G3-blue. When it runs at
> 115200
> >ifconfig
> >shows a lot of overruns. At 57600 it works fine, but it's slow :-((
> >
> >Does any of you own that serial port ?  Suggestions ??
>
> Which kernel ? With the DMA serial driver, it should work better than
> that... The Stealth hardware is probaly not responsible, it's just a line
> driver plugged instead of the modem, the actual zilog SCC is part of
> Apple's ASIC.


I've just tried the old non-dma code. Same problem :-(((
All works fine with Mac OS.


Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
