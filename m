To: "Nivedita Pitre" <Nivedita.Pitre@p-com.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux booting problems in the IBM Bubinga Board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Aug 2004 16:32:48 PDT."
             <s1110fc4.060@gateway.p-com.com>
Date: Thu, 05 Aug 2004 02:03:04 +0200
Message-Id: <20040805000309.07DAEC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
