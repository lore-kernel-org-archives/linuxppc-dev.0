Message-Id: <200003180622.BAA20354@shell.faradic.net>
Date: Fri, 17 Mar 2000 20:22:17 EST
From: jingai <jingai@floatingpenguins.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: YUP and RPM dependencies
Reply-To: jingai@floatingpenguins.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After I heard about the YellowDog Update Program (YUP) from someone on this
list, I went and downloaded the RPM and installed it.  However, it
initially performs some sanity checks, such as making sure all installed
RPMS pass dependency checks, and will not continue if this fails.. but I've
got a few RPMS (such as glibc, which requires the kernel-headers RPMS, but
I build my own kernel from sources) that I purposely installed even though
they fail dependency checks..

.so, my question is, is there a way to bypass this check (a force option
or somesuch)?  And if not, if anyone from  the YD team is here, please make
this an option.

But, as a side note, I'm ecstatic that this sort of app is finally out.. I
was just about to suck down the Debian install CDs, if for nothing other
than it's automatic package updater..

-j


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
