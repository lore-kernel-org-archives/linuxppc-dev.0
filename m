To: tguilliams@sbs.com
Cc: Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK build.sh seg faults 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "15 May 2003 10:09:34 PDT."
             <1053018568.22337.1115.camel@corona>
Date: Thu, 15 May 2003 20:06:06 +0200
Message-Id: <20030515180611.91606C6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1053018568.22337.1115.camel@corona> you wrote:
>
> > Which version of (native_ RPM is running on your system?
>
> The seg fault occurs during the build_package() for the target rpms
> which uses the ELDK SRPM included - rpm 4.0.3 from
> SRPMS/rpm-4.0.3-1.03b.src.rpm I believe.  Might be confused.  Need to
> trace out the build.sh better.

Again: which version of _native_ RPM is running on your system?

> The spec files run from bash (aka, /bin/sh).  My RedHat 7.2 version is -
>
> % /bin/sh --version
> GNU bash, version 2.05.8(1)-release (i386-redhat-linux-gnu)
> Copyright 2000 Free Software Foundation, Inc.
>
> What version are you using?

On the build host (RH-7.1):

# bash --version
GNU bash, version 2.04.21(1)-release (i386-redhat-linux-gnu)
Copyright 1999 Free Software Foundation, Inc.

> OK, I'll see what I can find out. My working build machine had been
> Redhat 7.2 two months ago but now, something's wrong.  I thought I'd try
> it on 8.0 to see if it would shed light but it didn't.

Make sure you run "up2date"...


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Roses are red
Violets are blue
Some poems rhyme

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
