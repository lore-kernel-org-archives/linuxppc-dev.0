To: Cindy Peters <cinpet@adaptivemicro.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Upgrading to kernel 2.4.6 with old init program 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Sep 2001 15:29:29 CDT."
             <41EDEC3C1B88D51186EB00A0C9CFADF702FA81@AMWMAIL>
Date: Sun, 23 Sep 2001 20:00:32 +0200
Message-Id: <20010923180037.DE0A61009E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <41EDEC3C1B88D51186EB00A0C9CFADF702FA81@AMWMAIL> you wrote:
>
> I am upgrading my Linux kernel from 2.2.13 to 2.4.6 on an MPC823. When the
> kernel startup process gets to running the sbin/init program I am getting a
> usage error for ld.so and then a kernel panic. It looks like it is
> attempting to run ld.so. I am still using an old ramdisk with old versions
> of executables that ran successfully on Linux 2.2.13. Have the file formats
> changed somehow? Do I need to get the source for the executables and rebuild
> them with the latest libraries? If so, where can I get them?

This souns as if you are still running code based on  libc-1.99.  You
need a modified version of /lib/ld.so.1 then. There is one on our FTP
server,  AFAIR  in  ftp://ftp.denx.de/pub/LinuxPPC/usr/src/ld.so* (or
maybe in the "patches" directory?).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nothing ever becomes real until it is experienced.       - John Keats

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
