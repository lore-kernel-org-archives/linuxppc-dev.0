Message-Id: <199812071128.GAA01786@smtp2.mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 7 Dec 1998 21:51:00 -0500
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
From: "Paul J. Schinder" <schinder@pobox.com>
Subject: Re: EGCS 1.1.1 FYI
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 06 Dec 1998 02:06:46 -0600, jeramy  wrote:
>
>
>Cygnus released 1.1.1 on Dec. 1 with the following PPC specific
>improvements.
>
>Fixed PPC/RS6000 LEGITIMIZE_ADDRESS macro and bug in conversion from
>unsigned ints to double precision floats. 
>Fixed handling of long longs for varargs/stdarg functions on the ppc. 
>Fixed code generation problems with gpr<->fpr copies for 64bit ppc. 
>Makes sure target libraries build with -fPIC for PPC targets.
>
>Good to see this much platform specific progress in a x.x.1 release. :)

So are Gary Thomas' patches still necessary? I downloaded his src rpm and
applied the patches that would apply to 1.1.1. As I recall, one said it
was aIready there, and a couple applied with offsets. I didn't use the rpm
itself because after bootstrapping the compiler and running make check the
Fortran compiler failed most of its tests, and I need a working Fortran
compiler. (And I nearly gave up on the rpm before stumbling across the
gperf patch in the contrib directory.) The make check on 1.1.1 failed
fewer tests than any egcs build I've done. I'm not that interested in
building kernels, but I do need working Fortran. I'm using 2.1.127 and
glibc-1.99 on a Performa 6400.







-------
Paul J. Schinder
schinder@pobox.com


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
