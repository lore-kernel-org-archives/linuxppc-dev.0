Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id DD33F2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Dec 2004 09:04:09 +1100 (EST)
To: ivica@asist-traffic.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 20 Dec 2004 20:25:39 +0100."
	<41C72733.9030300@asist-traffic.com>
Date: Mon, 20 Dec 2004 22:02:21 +0100
Sender: wd@denx.de
Message-Id: <20041220210226.E0438C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: i2c on mpc5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <41C72733.9030300@asist-traffic.com> you wrote:
> 
...
> module I would like to have I2C support working in my kernel.
...
> I tried with v various 2.4 kernels but I only had some success with a 
> kernel
> form metrowerks which I got from a colleague. This is it's output.

It works fine with the 2.4.x kernel on our CVS server.

> i2c-core.o: i2c core module
> i2c-dev.o: i2c /dev entries driver module
> i2c-core.o: driver i2c-dev dummy driver registered.
> i2c-algo-bit.o: i2c bit algorithm module
> i2c-proc.o version 2.6.1 (20010825)
> devfs_register(ttyS): could not append to parent, err: -17
> devfs_register(ttyS): could not append to parent, err: -17
> devfs_register(cua): could not append to parent, err: -17
> devfs_register(cua): could not append to parent, err: -17

Did you try NOT using devfs? 

> Also if anyone has already succeeded in supporting i2c for mpc5200 I 
> would love
> to hear your experience.

We did, in 2.4, where it works OK, at least as long as  the  hardware
is OK (some of the earlier Icecube boards had some issues).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The ultimate barrier is one's viewpoint.
                        - Terry Pratchett, _The Dark Side of the Sun_
