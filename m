Message-ID: <3993175B.127A2E59@motorola.com>
Date: Thu, 10 Aug 2000 15:58:03 -0500
From: Jeffrey Hawkins <Jeffrey.F.Hawkins@motorola.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC Versions of Glibc and GCC Status
References: <3992EAE6.27CF4490@motorola.com> <v03110703b5b8b78dd59f@[216.209.101.72]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin,

Thanks for the update...

However, my Thread Problem is not related to the recent fixes
discussed on the LinuxPPC List.  The Thread Problem I am having
is that when a Child Process attempts to create a Thread, the
Thread is created and executes, but the Child Process hangs in
the "pthread_create" (NOTE: Only the Child Process is creating
threads, not the Main Application Parent).  I don't really like
how this Application Package functions, but I don't have much
choice, since it is a 3rd Party Application Package that we
are using, that I am porting from AIX to LinuxPPC.  I have
modified this first Application executable to be
a single process with multiple threads - Everything works.
But, there are several other executables that have the
same Child Process with Threads Architecture, which I
just don't have the Project time to change (since the
changes ripple through other Package areas).  Thus,
I am turning to the updates and fixes to GLIB, which are
suppose to correct this issue, as well as, other issues.


Can I infer from your statement about the committal of your
changes to the GLIBC CVS Tree that GNU GLIBC 2.1.91 Version
should be PowerPC compatible ?  I must admit, I have not
kept up to date on the current Processors that the GNU
GCC and GLIBs are said to fully support.  Looking through
some of the archived mailings on this List, there would
seem to be some contention to GCC and GLIB full support,
or GNU Org's willingness to work on support, of PowerPC.



Jeff


"Kevin B. Hendricks" wrote:
>
> Hi,
>
> In case you were wondering, that patch has now (just today) been officially
> added to the glibc 2.1 branch of the official glibc cvs tree.  The patch in
> question prevents a race in setting the onwer to null on a mutex that
> resulting in tests in condvar.c to fail about the owner of the mutex not
> being the same as the caller of the thread (when it actually was).
>
> With this in place, the JDK native threads now seem to work well.
>
> Please let me know if this sodesn't fix your problems (I am always
> interested in the linuxthreads library when tracking down jdk failures).
>
> Thanks,
>
> Kevin

--
********************************************************

Jeffrey Hawkins

Senior Staff Software Engineer
Motorola Wireless Data Solutions Engineering

Address: DEPT:  DQ525
         MS:    IL-02-1055A
         1301 East Algonquin Road
         Schaumburg, IL 60196

Phone:   (847)576-7463
FAX:     (847)576-7737

********************************************************

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
