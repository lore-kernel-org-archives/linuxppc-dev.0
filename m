Message-ID: <3A9C2733.D5B470F8@arlut.utexas.edu>
Date: Tue, 27 Feb 2001 16:16:19 -0600
From: Ken Offer <koffer@arlut.utexas.edu>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC Kernel 2.4.2 build (multiple compilations error)
References: <Pine.A41.3.96LJ1.1b7.1010227104958.75940C-100000@unlserve.unl.edu> <3A9C0793.2AEBE8B0@arlut.utexas.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ken Offer wrote:
>
> Takashi Oe wrote:
> > It's not a gcc problem.  Maybe, wait a day or two and refetch the archive?
>
> I guess I'll have to. :)

A Linux guru here found the problem (thanks Mike D.!!!).

And now for those searching the archives desperately for an answer:

If you run into the "gcc: cannot specify -o with -c or -S and multiple
compilations" error while building a kernel, the following might help.
The environment variable TARGET_ARCH might be set to "ppc" from a
previous build.  Doing an "unset TARGET_ARCH" cleared up the build
problem for me. :)

--
______________________________________________________________
Kenneth Ray Offer, II
Sr. Systems Analyst
Applied Research Laboratories/SDD
University of Texas at Austin
Office (512) 835-3859   FAX (512) 835-3259

Any opinions expressed above are mine and not necessarily
those of my employer.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
