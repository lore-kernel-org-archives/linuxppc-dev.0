Message-Id: <200001240503.GAA26020@denx.local.net>
To: Brendan.Simon@ctam.com.au
cc: dony <dony.he@huawei.com.cn>, Grant Carter <gcarter@eng.uct.ac.za>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile dynamic apps for mpc860 on ix86
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Jan 2000 14:00:06 +1100."
             <388BC036.7BC21AE1@ctam.com.au>
Date: Mon, 24 Jan 2000 06:03:40 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <388BC036.7BC21AE1@ctam.com.au> you write:
>
> I am using RedHat-5.2 and I don't have any problems.  There might be some problems with RedHad-6.0 and/or RedHat-6.1.  I
> have heard of some people having problems with RedHat-6.x but I think that might be with RTEMS.  Anyway, RedHat-5.2 works
> for me.

RH-6.0 and 6. work fine for me and several of my customers.

> Yes.  I have successfully built glibc-2.1.1 and glibc-2.1.2 with egcs-1.1.2 and binutils-2.9.1.0.19a.
> I have copied all the shared libraries to my nfs root filesystem under /lib.  I still get segmentation faults when I try to
> run the dynamic application.  Arghh !!!  This is so annoying.

Make sure you use ONLY files compiled in your  new  environment,  not
ANY files that might exist from older versions in your NFS tree.

Make sure the shell you are running is statically linked!

The easiest way to test this is to copy all relevant files to  a  new
place (say, /test/bin and /test/lib) and then test with "chroot /test".


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It's when they say 2 + 2 = 5 that I begin to argue."    - Eric Pepke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
