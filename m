Date: Tue, 14 Dec 1999 18:40:50 -0500
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Found problem with math libs. How do I fix it?
Message-ID: <19991214184050.A16409@drow.res.cmu.edu>
References: <v04220800b47c3c865893@[192.168.1.4]> <Pine.LNX.4.10.9912141504530.9556-100000@shell.unixbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.9912141504530.9556-100000@shell.unixbox.com>; from ajoshi@shell.unixbox.com on Tue, Dec 14, 1999 at 03:20:37PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Dec 14, 1999 at 03:20:37PM -0800, Ani Joshi wrote:
> 
> 
> 	can you try including <tgmath.h> and trying?  if that doesn't help
> then try using truncf() for floats, etc..   i believe there's a bug in the
> macros perhaps, i'll work on it a bit.

It's a problem with prototyping - look at -Wall output!  I'm talking to
the libc list about the problem now.


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
