To: Jos Beck <jos_beck@euronet.nl>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C implementation on MPC8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 05 May 2004 11:35:03 +0200."
             <4098B547.5070101@euronet.nl>
Date: Wed, 05 May 2004 12:03:10 +0200
Message-Id: <20040505100315.2C204C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4098B547.5070101@euronet.nl> you wrote:
>
> I am trying to get some i2c devices (RTC, EEPROM) to run on an MPC8260
> with kernel version 2.4.21.

Use a more recent kernel.

> I have seen some fragmented information in the kernel source
> documentation and on this mailing list, but it's not clear to me what
> parts I can use and what I have to write myself.
>
> Could anyone tell me where and how to start?

The linuxppc_2_4_devel tree on our CVS server has I2C support for the
8260,  and  also  includes  several  I2C  based  RTC   modules.   See
http://www.denx.de/re/linux.html

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
By the way, ALL software projects are done by iterative  prototyping.
Some companies call their prototypes "releases", that's all.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
