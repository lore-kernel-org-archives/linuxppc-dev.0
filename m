From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Michael Fenske <michael.fenske@arcormail.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with glibc-2.1.3-0a.src.rpm ?
Date: Wed, 13 Oct 1999 00:53:25 +0200
Content-Type: text/plain
References: <3803A7BC.4175E431@arcormail.de>
In-Reply-To: <3803A7BC.4175E431@arcormail.de>
MIME-Version: 1.0
Message-Id: <99101300580600.00880@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Die, 12 Okt 1999 schrieb Michael Fenske:
>Hi,
>
>can anyone explain me the following output ?
>
>+ ../configure --prefix=/usr --enable-add-ons=yes --without-cvs ppc-redhat-linux
>creating cache ./config.cache
>checking host system type... powerpc-redhat-linux-gnu
>checking sysdep dirs... sysdeps/powerpc/elf crypt/sysdeps/unix
>linuxthreads/sysdeps/unix/sysv/linux linuxthreads/sysdeps/pthread
>linuxthreads/sysdeps/unix/sysv
>linuxthreads/sysdeps/unix linuxthreads/sysdeps/powerpc
>sysdeps/unix/sysv/linux/powerpc sysdeps/unix/sysv/linux sysdeps/gnu
>sysdeps/unix/common sysdeps/unix/mman sysdeps/unix/inet
>sysdeps/unix/sysv sysdeps/unix sysdeps/posix sysdeps/powerpc
>sysdeps/wordsize-32 sysdeps/ieee754 sysdeps/libm-ieee754
>sysdeps/generic/elf sysdeps/generic
>checking for a BSD compatible install... /usr/bin/install -c
>checking whether ln -s works... yes
>checking build system type... powerpc-redhat-linux-gnu
>checking for gcc... egcs
>checking version of egcs... v. ?.??, bad
>checking for make... make
>checking version of make... 3.77, ok
>checking for msgfmt... msgfmt
>checking version of msgfmt... 0.10.35, ok
>checking for makeinfo... makeinfo
>checking version of makeinfo... 3.12, ok
>configure: error:
>*** Some critical program is missing or too old.
>*** Check the INSTALL file for required versions.
>Bad exit status from /var/tmp/rpm-tmp.55764 (%build)
>
>I get this if I do a 'rpm --rebuild glibc-2.1.3-0a.src.rpm'
>
>What I don't understand is that the configure-script insists that I have
>egcs installed, but I definitely have gcc-2.95.1 installed.

Did you install all parts of gcc-2.95.1? cpp is easily forgotten. What output
do you get from 'egcs -v' and 'gcc -v'?

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
