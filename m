To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8245 and PCF8563 RTC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "25 Jul 2003 09:24:47 CDT."
             <1059143087.4969.21.camel@triffo.arlut.utexas.edu>
Date: Fri, 25 Jul 2003 18:15:36 +0200
Message-Id: <20030725161541.CE060C602D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1059143087.4969.21.camel@triffo.arlut.utexas.edu> you wrote:
>
> Do any of the boards you mentioned use the same i2c-adap driver that I
> mentioned I was using for my board? Is there a better i2c-adap driver

No, they don't.

> for an MPC8245 board? I think the i2c driver for my board is the
> culprit, not the driver for the real time clock. As always all help is
> appreciated.
...
> > Not with a MPC8245, but with MPC8240 (on CU824  board),  MPC8250  (on
> > PM825 board), and MPC8260 CPUs (on PM826 and CPU86 boards).

CU824 uses i2c-algo-8240 + i2c-cu824
PM825 and PM826 use i2c-algo-8260 + i2c-pm826
CPU86 uses i2c-algo-8260 + i2c-cpu86


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Administration: An ingenious abstraction  in  politics,  designed  to
receive the kicks and cuffs due to the premier or president.
- Ambrose Bierce

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
