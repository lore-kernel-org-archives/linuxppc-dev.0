To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Error while rebuilding glibc for ELDK 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Jul 2002 14:11:20 +0200."
             <3D2C2468.A733D375@imc-berlin.de>
Date: Wed, 10 Jul 2002 14:39:10 +0200
Message-Id: <20020710123915.6ECE71086F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D2C2468.A733D375@imc-berlin.de> you wrote:
>
> I am using Wolfgang's ELDK for my ppc linux development. It works very good.
>
> Thanks a million, Wolfgang!

Thanks for the compliments :-)

> But since I want to use a 2.4.19 kernel instead of the 2.4.4 I tried to rebuild
> the glibc.

What has the kernel  version  to  do  with  the  C  library  used  by
applications?

> I pulled the glibc-2.2.1-0f.src.rpm from ftp.leo.org installed it in
> /opt/ELDK/usr/src/denx/SRPMS and started rebuilding the glibc with

Ummm... you mean you pulled the source RPM from the  ELDK  directory?
Or what?

> scholz@pinguin:/opt/ELDK/usr/src/denx/SPECS> ppc_8xx-rpm -ba glibc.spec
>
> It all works well until the installation scripts:
...
> So what's the problem here? Is the file "el.mo" broken? Can I skip this? (I am
> sure I won't need el.mo)

If I remember correctly, you're running on a SuSE  system?  We  never
verified  building  in sucha n environment. Under RH-7.x (x=1,2,3) it
works fine.

> BTW: Wolfgang, do I have to be superuser to rebuild a target package for ELDK? I
> guess not.

No. The only case where superuser permissions are needed is to create
the /dev entries (running the ELDK_MAKEDEV script) after installation
of the tools - but this is only necessary when you want to export the
native tools on a NFS server.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Karl's version of Parkinson's Law: Work expands to  exceed  the  time
alloted it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
