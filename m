To: srinivas pulipati <srinivasp@multitech.co.in>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ramdisk.image.gz 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Dec 2001 12:54:11 +0530."
             <3C22E39B.B3FBB875@multitech.co.in>
Date: Fri, 21 Dec 2001 09:51:21 +0100
Message-Id: <20011221085126.5647610E21@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C22E39B.B3FBB875@multitech.co.in> you wrote:
>
> i am trying to boot mpc860 based board with ramdisk support.
> i compiled the kernel and built the ramdisk also. but it is hanging
> after
> trying to run init file in the ramdisk.
>
> so can you pls tell me where can i get a pre built working
> ramdisk.image.gz?

See ftp://ftp.denx.de/pub/LinuxPPC/usr/src/simple-ramdisk.image.gz
(raw ramdisk.image.gz) or
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/simple-ramdisk.PPCBoot
(same as PPCBoot image).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Our OS who art in CPU, UNIX be thy name.
Thy programs run, thy syscalls done,
In kernel as it is in user!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
