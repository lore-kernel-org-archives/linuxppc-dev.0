Date: Wed, 7 Feb 2001 16:21:33 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Accessing global symbols from shared library
Message-ID: <20010207162133.A17743@drow.them.org>
References: <00cc01c0913a$7d647480$6c125acf@mrsl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00cc01c0913a$7d647480$6c125acf@mrsl.com>; from moloney@mrsl.com on Wed, Feb 07, 2001 at 02:16:35PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 07, 2001 at 02:16:35PM -0500, Tim Moloney wrote:
>
> I am currently trying to port a Solaris application to Linux.  The
> Solaris application dynamically loads custom shared libraries which
> can access symbols in the main executable.  This is not a clean
> design, but it works.  From what I've seen so far, the Linux
> runtime loader does not allow a shared library to access symbols in
> the main executable.
>
> If someone knows of a linker switch or something that allows shared
> libraries to access global symbols, please let me know.

You're probably looking for -rdynamic...

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
