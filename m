Message-ID: <3AF2C4C5.3C1ECE55@mvista.com>
Date: Fri, 04 May 2001 11:03:33 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Freddy Lugo <wilflugo@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging infor after decompress_kernel
References: <20010504144827.94868.qmail@web9907.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Freddy Lugo wrote:

>  but then how I obtain the debug info of the kernel
>  after bootloading?

You need to use the 'vmlinux' file for the information.
I simply 'gdb vmlinux' then remotely attach to the debugger,
either KGDB or Abatron.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
