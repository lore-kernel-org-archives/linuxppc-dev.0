From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Soumya Desai" <soumya@tejasnetworks.com>, <wd@denx.de>
Cc: <gopi@tejasnetworks.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Accessing file from drivers (fwd)
Date: Fri, 16 Mar 2001 09:28:00 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMOECDDAAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3AB1A57E.669B3166@tejasnetworks.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hi Wolfgang,
>
>      The exact problem that we're trying to solve, is to program
> an FPGA with a hex file
> which is in our file system.  But the problem is general is to
> have a way to write  a
> system  call  say 'sys_copy'  which will copy one file to
> another.  An user-mode
> application would read from one file and write back to another,
> which would result in
> copying  the data from the file driver ( kernel space ) to the
> user-space,  and again
> back to the kernel space.  We were curious as to whether a way
> existed by which we can
> do the read and write, sitting in the kernel space itself.

I don't know if I well understand the problem, but it seems to me that you
can use the mmap system call ...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
