To: "Aman" <aman@mistralsoftware.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Downloading Linux image using Riscwatch 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 01 Oct 2002 23:42:43 +0530."
             <001b01c26976$233e0640$370da8c0@aman>
Date: Tue, 01 Oct 2002 20:40:56 +0200
Message-Id: <20021001184101.EF497FA97@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001b01c26976$233e0640$370da8c0@aman> you wrote:
>
>  I am using PPC 440GP processor on custom board. This board doesnt not have
>  Ethernet support and there is no rom monitor code in the board. Is it
>  possible to download the Linux image to the board using JTAG . If so what
>  type of image should I build.

You can download the kernel, but it will not run ;-)

The Linux kernel relies on a lot of initialization to be done by  the
firmware  -  things  like initializing and sizing the memory, passing
boot arguments etc.

I suggest you start porting PPCBoot.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The first 90% of a project takes 90% of the time, the last 10%  takes
the other 90% of the time.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
