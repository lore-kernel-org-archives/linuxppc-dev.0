To: "Luo Yanjun" <linux_arm_kernel@sohu.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: where does kernel config MPC860 memory controller BRx register? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 29 Sep 2002 15:23:13 +0800."
             <03db01c26789$12dcb5b0$6100a8c0@udtech.net>
Date: Sun, 29 Sep 2002 10:33:58 +0200
Message-Id: <20020929083403.001EAFA8F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <03db01c26789$12dcb5b0$6100a8c0@udtech.net> you wrote:
>
> I want to use CS3 of MPC860 for some devices,
> so I need config BR3 register, I don't know where
> to config it, I have not find BR0's config code.
> Where can I find BR0's config code? If I find that,
> I think I can place my code there.

The initialziation of the memory controller (and things like  testing
and  sizing available memory) have to be done by the firmware on your
board, so look in your firmware sources.

For additional chip selects, you can  of  course  add  the  necessary
BRx/ORx initialization in the init function of the device driver that
will be accessing this hardware.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I think it's a new feature. Don't tell anyone it was an accident. :-)
  -- Larry Wall on s/foo/bar/eieio in <10911@jpl-devvax.JPL.NASA.GOV>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
