To: "John F. Davis" <davis@skink.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ramdisk size using montevista 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Mar 2001 17:57:58 EST."
             <20010321175758.A7228@skink.net>
Date: Thu, 22 Mar 2001 00:13:41 +0100
Message-Id: <20010321231346.BFB2F281DC@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010321175758.A7228@skink.net> you wrote:
>
> I am trying to boot hardhat linux with a small ram disk.  However, libc is more
> than 4 megs by itself.  Is there something obvious I can do/read?  I tried using
> busybox, but that only makes the bin directory small.  I don't really know
> what I should do about the /lib directory.

Read the FAQ, and use strip.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
######## This message was made from 100% recycled electrons. ########

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
