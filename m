To: greggiraud@netcourrier.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: using bdi2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 21 Apr 2003 12:22:53 EST."
             <mnet1.1050920573.22642.greggiraud@netcourrier.com>
Date: Mon, 21 Apr 2003 12:38:05 +0200
Message-Id: <20030421103810.F2970C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <mnet1.1050920573.22642.greggiraud@netcourrier.com> you wrote:
>
> I am trying to debug my linux with a bdi2000.
> I succeed in loading ppcboot into flash. But I can't debug!
>
> pc_82xx-gdb
> target remote 192.168.15.3:2001
>
> And then how to say the debugger to break at a specific line in a specific file like l 23 in uart.c?

(gdb) b uart.c:23


Maybe you should start reading GDB documentation?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Why is an average signature file longer than an average Perl script??

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
