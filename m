Message-Id: <s1111b54.006@gateway.p-com.com>
Date: Wed, 04 Aug 2004 17:22:13 -0700
From: "Nivedita Pitre" <Nivedita.Pitre@p-com.com>
To: <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux booting problems in the IBM Bubinga Board
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes, I tried both with and without the console= argument,
selecting ttyS0 and baud 9600. Same result.

>>> Wolfgang Denk <wd@denx.de> 08/04/04 05:03PM >>>
In message <s1110fc4.060@gateway.p-com.com> you wrote:
>
> I am using U-boot to boot linux kernel on the IBM Bubinga (405EP board). Using kernel version 2.6.7, which has a default config file for this board. Changed the board info structure to match u-boot's board information structure. Using the mkimage utilit

PLEASE don't use such long lines. Press ENTER after some 60...70
characters or so.

> ach_dep calls output some messages. This tells me that code reaches in start_kernel, however, after console_init, the serial port dies. I assume this is because we initialize the serial port, and turn off early debug. I commented o

Did you pass some "console=..." boot argument?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
One difference between a man and a machine is that a machine is quiet
when well oiled.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
