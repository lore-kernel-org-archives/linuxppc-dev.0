Message-ID: <3984378C.E10CE694@denise.shiny.it>
Date: Sun, 30 Jul 2000 10:11:24 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Stealth port problems
References: <39811B2C.4D34DDD@denise.shiny.it> <20000728083426.19235@mailhost.mipsys.com> <398426BC.67FCDC6E@denise.shiny.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Giuliano Pochini wrote:
>
> > >Hi!  I have troubles with my stealth port on a G3-blue. When it runs at
> > 115200
> > >ifconfig
> > >shows a lot of overruns. At 57600 it works fine, but it's slow :-((

The problem is definitely X.  I made a lot of tests: with dma and non-dma
serial driver, X accelerated, non accelerated, X bare.bone (started with
xinit). The problem is X. When X is running the serial ports looses packets
:-((
Am I the only one who is having this problem ???  Why does X cause overruns ??

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
