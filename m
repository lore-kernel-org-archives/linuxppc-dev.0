Message-ID: <3B8F4151.E69886CB@imc-berlin.de>
Date: Fri, 31 Aug 2001 09:48:33 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: HHL 2.0 Journeyman and SuSE Linux
References: <20010830175217.H858@zax> <3B8DFF2F.44AFE98F@imc-berlin.de> <20010830092150.O18618@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > is it possible to install and use the HHL 2.0 Journeyman Edition on a
> > SuSE Linux 7.x machine?

Yep. It is!

Just "patch" the script hhl-host-install:

--- hhl-host-install.ORIG       Fri May 25 18:34:49 2001
+++ hhl-host-install    Thu Aug 30 18:07:22 2001
@@ -532,8 +532,8 @@
     elif [ -r /etc/SuSE-release ]
     then
        RPMVERSION=3
-       RPMSUBDIR=suse70
-       HOST=suse
+       RPMSUBDIR=redhat62
+       HOST=redhat
        HOSTARCH=i386

     elif [ -r /etc/yellowdog-release ]

"redhat62" is because of RPM version (3.0.06) used on SuSE 7.2.

Thanks Steven, well done! ;-)

> Possibly.  The RedHat rpms should 'just work'.  Or you can download the
> source rpms and compile the host tools for your setup.  The target binaries
> are all the same.

They do work, indeed. At least for building a kernel.

Thanks Tom.


Steven Scholz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
