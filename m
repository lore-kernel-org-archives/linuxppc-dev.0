Message-ID: <3984273D.1A818C44@student.ethz.ch>
Date: Sun, 30 Jul 2000 15:01:49 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Giuliano Pochini <pochini@denise.shiny.it>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Stealth port problems
References: <39811B2C.4D34DDD@denise.shiny.it>
	 <20000728083426.19235@mailhost.mipsys.com> <398373C9.2D38B631@denise.shiny.it>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Giuliano Pochini wrote:

> Now I run XF4 and the problem is even worse. I get underruns at 38400
> :-(((((((((((((
>
> What can I do ?  And why X affects the serial port ??

I assume you are running an accelerated driver, which moves load from the CPU
to the graphics chip, which may increase interrupt and/or bus load/latency.


Michel


--
Chaos, panic and disorder -- my work here is done.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
