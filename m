Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id F33A1679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Aug 2006 06:11:29 +1000 (EST)
To: "Michael Carey" <MCarey@nearfield.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ELDK 3.1.1 support for x86_64 host architecture 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Aug 2006 17:11:31 PDT."
	<44D22E43020000710000243E@webmail.nearfield.com>
Date: Fri, 04 Aug 2006 22:11:26 +0200
Sender: wd@denx.de
Message-Id: <20060804201127.00D2D352640@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <44D22E43020000710000243E@webmail.nearfield.com> you wrote:
> I found the subject "ELDK 3.1.1 support for x86_64 host architecture" in the archives (Apr 15 2005) which describes my problem, however there was never any posting of a resolution.

There was none, as  there  is  no  problem.  ELDK  3.1.1  (and  later
versions)  runs  fine on x86_64 hosts, assuming you're using any sane
Linux distribution. For example:

-> ppc_8xx-gcc -v
Reading specs from /opt/eldk-3.1.1/usr/bin/../lib/gcc-lib/ppc-linux/3.3.3/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --with-system-zlib --enable-__cxa_atexit --with-newlib --enable-languages=c,c++ --disable-libgcj --host=i386-redhat-linux --target=ppc-linux
Thread model: posix
gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-9)
------------------------^^^^^^^^^^
-> uname -a
Linux pollux.denx.de 2.6.10-1.771_FC2smp #1 SMP Mon Mar 28 01:05:47 EST 2005 x86_64 x86_64 x86_64 GNU/Linux
-----------------------------------------------------------------------------^^^^^^
-> cat /etc/issue
Fedora Core release 2 (Tettnang)
...

>         package rpm-4.1.1-1.8xa_10 is intended for a i386 architecture

Your Linux distro is kind of broken.

> The details on my system are:
...
> Welcome to SUSE LINUX 10.1 (X86-64) - Kernel \r (\l).

Yes, SuSE has always found interesting ways to  break  compatibility.
That's  why  I avoid it. IIRC, SuSE provides a special tool "linux32"
which has to be used to run 32-bit applications on a x86_64 system.

Don't ask  me  why  they  need  it.  Other  distros  run  the  32-bit
applications just fine without such intricacy.



Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There are very few personal problems that cannot be solved through  a
suitable application of high explosives.
