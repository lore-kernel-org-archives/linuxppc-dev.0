To: Prakash kanthi <pkanthi@yahoo.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ramdisk mount problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 Jan 2003 10:42:36 PST."
             <20030114184236.43688.qmail@web41211.mail.yahoo.com>
Date: Tue, 14 Jan 2003 19:57:50 +0100
Message-Id: <20030114185755.297BEC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030114184236.43688.qmail@web41211.mail.yahoo.com> you wrote:
>
> I am trying to use 2MB ramdisk image from denx as my
> linux filesystem. Linux kernel fails to mount the
> 'ext2' type file system from initrd. I pin pointed the
> problem.

There are at least two important preconditions:

* You must enable support for ramdisk, initial ramdisk, and ext2
  filesystem, in your kernel config
* you must pass "root=/dev/ram rw" (and probably some more) as
  kernel boot argument.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Everything should be made as simple as possible, but not simpler."
                                                    - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
