Date: Thu, 23 Mar 2000 16:58:52 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: Cort Dougan <cort@fsmlabs.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling interrupts
In-Reply-To: <20000323144536.J11342@medea.fsmlabs.com>
Message-ID: <Pine.LNX.4.21.0003231654120.31863-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Cort!

> Does it have to be a user mode piece of code?  You're going to have real
> trouble figuring that out if so.  Could you put that small portion of code
> into a kernel module and just load it from your user program to do what it
> needs to?

Well, this code needs to read some data continously. Then the data must
be processed and written to a file.

If you expect problems, I could create a new syscall and pass a buffer to
it. Probably this should be Ok. But the buffer can be huge (comparable
with the RAM size), so I would like to avoid copying data. This means that
the kernel needs to write to the userspace buffer directly.

Thank you for the reply.

Regards,
Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
