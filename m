To: weiwu <weiwu@isdn.iscas.ac.cn>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: flash !a questionof block-driver 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 05 Sep 2001 13:05:52 +0800."
             <200109050504.NAA24541@isdn.iscas.ac.cn>
Date: Wed, 05 Sep 2001 20:37:47 +0200
Message-Id: <20010905183753.0B8B910CC5@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200109050504.NAA24541@isdn.iscas.ac.cn> you wrote:
>
> The ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz sources also include a
> flash translation layer (ftl.c) so flash can be used as a read/write

This is old, no: ancient stuff. Please forget that you ever saw it ;-)

> I have Intel 28F320J5(4MBytes, 8bit) flash memory!
> where can I found it if you know,and can I use my intel flash memory for your flash device
> driver if you have driver!

A character device driver is included with our sources, see for instance
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-07-23.tar.bz2

The standard solution is to use MTD, which is part of recent kernels, too.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Karl's version of Parkinson's Law: Work expands to  exceed  the  time
alloted it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
