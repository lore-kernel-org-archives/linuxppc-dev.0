To: Daris A Nevil <dnevil@snmc.com>
Cc: ?????? <engineersong@hanmail.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC3 console problem on MPC860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Mar 2001 08:57:07 MDT."
             <3AC49EC3.978D9A4A@snmc.com>
Date: Fri, 30 Mar 2001 17:37:46 +0200
Message-Id: <20010330153751.EE41228827@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3AC49EC3.978D9A4A@snmc.com> you wrote:
>
> I had problems trying to get the uart.c driver to do what you wanted as
> well.  I don't think it was really meant to support both SCC and SMC at
> the same time.  I ended up splitting the driver into two different

I cannot verify this problem.

> drivers, making one work just for the SCC, and the other only for the
> SMC.  This works quite well.

This is really not needed.

We have tested the normal uart driver in a setup running on 5  serial
ports  (2  x  SMC, 3 x SCC, with Ethernet of the 4th SCC). No serious
load tests so  far,  but  basic  I/O  functions  worked  without  any
problems.

> The code is in the QSLinux release, which you can download from
> ftp:://qslinux.org.  When you untar the kernel you can find the two
> drivers in the directory snmc/qslinux/kernel/drivers/char.

Ummm... AFAIK QSLinux is based on a 2.2.5  kernel?  That's  _awfully_
old.  I  can  imagine  that there were lots of problems with the uart
driver at this time. And other bugs as well.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"How is this place run - is it an anarchy?"
"No, I wouldn't say so; it is not that well organised..."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
