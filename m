Message-ID: <3CE2F854.1020908@csiro.au>
Date: Thu, 16 May 2002 10:07:48 +1000
From: James Gunning <James.Gunning@csiro.au>
MIME-Version: 1.0
To: yellowdog-general@lists.terrasoftsolutions.com,
	linuxppc-dev@lists.linuxppc.org
Subject: IBM jdk needs kernel patch to fix floating stacks problem? LD_ASSUME_KERNEL
References: <20020515212704.714BF1FC2D@newhope.terraplex.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi ppc'ers
        From discussion on the ibm.software.java.linux newsgroup
---snipped-- below, it's clear
we ppc users need some kernel patch to get the IBM jdk's (1.3.0, 1.3.1)
to work.
Anybody got any  ideas if this is possible? Where to get the patch? Is
there a patch?

Any views welcome,
                                      James.

-----snipped from ibm.software.java.linux -----

> Hi all,
>
> When trying to use the pSeries JDK with Tomcat v4.0.3, it bombs out on
> startup like so:
>
> **Out of memory, aborting**
>
> *** panic: JVMST058: Cannot allocate memory in initGcHelpers(3)
>
> It then leaves a 60MB or so core file, and exits.
>
> I have tried all sorts of combinations of -X options to do with memory,
> none of them make any difference.
>
> The target platform is LinuxPPC v2.4.19-pre7 (v2.4.18 has same problem)
> under YDL v2.2, with glibc 2.2.5-0.19a.
>
> Anyone shed any clue? Is anyone from IBM interested in the core dump so
> it can be debugged?
>
> Regards,
> Graham

As I have just posted on another thread:


It looks very much like the floating stack thing.  If YellowDog don't
give you the LD_ASSUME_KERNEL patch, then you can compile
glibc with floating stacks disabled.  This course of action is only open
to the brave and the foolish.

Neil

-----snipped from ibm.software.java.linux -----


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
