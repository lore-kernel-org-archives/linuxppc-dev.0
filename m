Message-ID: <398741C3.4845BA95@student.ethz.ch>
Date: Tue, 01 Aug 2000 23:31:47 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC X Server
References: <398726FD.C1A79E2B@student.ethz.ch> <20000801204113.29901@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >> >Great, I'd happily beta-test and/or help, will that be in your
> >> >rsync-tree or in 2.4?
> >>
> >> It's far from finished yet. It will be in 2.4 bk tree once done
> >
> >Cool, so it will be in our APUS 2.4 tree :)
>
> Well, I don't see what good Uni-North AGP bridge support can be to APUS
> machines, but if you think it's cool ...

I don't have a bitkeeper tree, but the APUS tree is based on it, so I can
build the agpgart stuff from there.


> >> Also, I need to figure out why XF4 (Franz 4.0.1 RPMs) die with 2.4 on
> >> both my Pismo and my G4.
> >
> >Strange, it works fine here running 2.4.0-test4 from linux-pmac-devel...
>
> I'll compare with this kernel. Also, which version of glibc do you have ?

book(~): dpkg -l|grep libc6
ii  libc6          2.1.3-10       GNU C Library: Shared libraries and Timezone
ii  libc6-dev      2.1.3-10       GNU C Library: Development Libraries and Hea

> Did you compile XF4 yourself ? If yes, which gcc did you use ? (just in
> case...)

book(~): gcc -v
Reading specs from /usr/lib/gcc-lib/powerpc-linux/2.95.2/specs
gcc version 2.95.2 20000220 (Debian GNU/Linux)

Compiled both X 4.0.1 (more or less stock AFAIR) and the kernel with that.


Michel


--
                               Reboot America.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
