To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8245 and PCF8563 RTC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "24 Jul 2003 17:07:04 CDT."
             <1059084423.4969.11.camel@triffo.arlut.utexas.edu>
Date: Fri, 25 Jul 2003 00:26:49 +0200
Message-Id: <20030724222654.7B845C602D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Matthew,

in message <1059084423.4969.11.camel@triffo.arlut.utexas.edu> you wrote:
>
> Has anyone had any success using an MPC8245 and a Philips PCF8563 real
> time clock in linux? Everything works in U-Boot but I can not get
> everything working in linux.

Not with a MPC8245, but with MPC8240 (on CU824  board),  MPC8250  (on
PM825 board), and MPC8260 CPUs (on PM826 and CPU86 boards).

> Obviously it has a transfer error, but I am curious if anyone has any
> experiences with the same situation. Anyone have any ideas?

Works fine here.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I read part of it all the way through.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
