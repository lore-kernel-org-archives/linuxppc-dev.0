To: Prakash kanthi <pkanthi@yahoo.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Smallest Initrd (ram disk) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 26 Dec 2002 14:47:30 PST."
             <20021226224730.21626.qmail@web41210.mail.yahoo.com>
Date: Fri, 27 Dec 2002 01:22:39 +0100
Message-Id: <20021227002244.B4C9FC6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021226224730.21626.qmail@web41210.mail.yahoo.com> you wrote:
>
> If i want to build a smallest possible initrd, can you

The  smallest  possible  ramdisk  would  probably  contain  just  the
/dev/directory  with  an  entry  for  /dev/console,  and a statically
linked application program by the name of /sbin/init or so.

> suggest where i can get it from or how i can build it?

See  Documentation/initrd.txt  that  comes  with  your  Linux  kernel
sources.

> I am working with a custom made PPC405 based board
> with just 8MB RAM.

8 MB is a lot. You  can  run  pretty  complex  systems  there  -  for
example, the default ramdisk size for the SELF package is 4 MB, about
half  of  which  is  unused. See the ELF package as included with our
ELDK,  or  see  ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/  for  am
older (and smaller) version.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"What is wanted is not the will to believe, but the will to find out,
which is the exact opposite." - Bertrand Russell, _Sceptical_Essays_,
1928

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
