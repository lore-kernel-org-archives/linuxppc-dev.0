Message-ID: <39FD404C.2E213ADA@wanadoo.fr>
Date: Mon, 30 Oct 2000 10:33:00 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
CC: Michael Norton <mnorton@cisco.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel source rpm
References: <200010281936.MAA18635@cisco.com> <v04220802b622ea31cf0b@[10.0.0.42]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" wrote:
>
> At 12:36 PM -0700 10/28/00, Michael Norton wrote:
> >hi,
> >
> >I am working on an application which requires the header file
> ><linux/limits.h>.
> >Which file do I need to rpm from the LinuxPPC 2000 CD-Rom to install kernel
> >source?
>
> Don't do that.  Kernel header files are not intended to be directly
> #include'd into user applications.  Use the the GNU C and/or C++
> libraries and headers like you're supposed to, and you will not
> depend on kernel files at all.

This is correct in the Linus-approved True Linux Userspace (tm). Problem
is that on RedHat based systems like linuxppc, glibc doesn't contain
/usr/include/linux except as a symlink to /usr/src/linux/include/linux.
So you need either kernel sources from some archive or the
"kernel-headers" RPM.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
