Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8245 and PCF8563 RTC
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030724222654.7B845C602D@atlas.denx.de>
References: <20030724222654.7B845C602D@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1059143087.4969.21.camel@triffo.arlut.utexas.edu>
Mime-Version: 1.0
Date: 25 Jul 2003 09:24:47 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Do any of the boards you mentioned use the same i2c-adap driver that I
mentioned I was using for my board? Is there a better i2c-adap driver
for an MPC8245 board? I think the i2c driver for my board is the
culprit, not the driver for the real time clock. As always all help is
appreciated.

Thanks,
Matthew

On Thu, 2003-07-24 at 17:26, Wolfgang Denk wrote:
> Dear Matthew,
>
> in message <1059084423.4969.11.camel@triffo.arlut.utexas.edu> you wrote:
> >
> > Has anyone had any success using an MPC8245 and a Philips PCF8563 real
> > time clock in linux? Everything works in U-Boot but I can not get
> > everything working in linux.
>
> Not with a MPC8245, but with MPC8240 (on CU824  board),  MPC8250  (on
> PM825 board), and MPC8260 CPUs (on PM826 and CPU86 boards).
>
> > Obviously it has a transfer error, but I am curious if anyone has any
> > experiences with the same situation. Anyone have any ideas?
>
> Works fine here.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> I read part of it all the way through.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
