From: Benjamin Herrenschmidt <bh40@calva.net>
To: Giuliano Pochini <pochini@denise.shiny.it>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Stealth port problems
Date: Fri, 28 Jul 2000 10:34:26 +0200
Message-Id: <20000728083426.19235@mailhost.mipsys.com>
In-Reply-To: <39811B2C.4D34DDD@denise.shiny.it>
References: <39811B2C.4D34DDD@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi!  I have troubles with my stealth port on a G3-blue. When it runs at
115200
>ifconfig
>shows a lot of overruns. At 57600 it works fine, but it's slow :-((
>
>Does any of you own that serial port ?  Suggestions ??

Which kernel ? With the DMA serial driver, it should work better than
that... The Stealth hardware is probaly not responsible, it's just a line
driver plugged instead of the modem, the actual zilog SCC is part of
Apple's ASIC.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
