Message-ID: <398726FD.C1A79E2B@student.ethz.ch>
Date: Tue, 01 Aug 2000 21:37:33 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Takashi Oe <toe@unlserve.unl.edu>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC X Server
References: <39871F8A.C2B1D262@student.ethz.ch> <20000801191739.26835@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >
> >Great, I'd happily beta-test and/or help, will that be in your rsync-tree
> > or in 2.4?
>
> It's far from finished yet. It will be in 2.4 bk tree once done

Cool, so it will be in our APUS 2.4 tree :)


> Also, I need to figure out why XF4 (Franz 4.0.1 RPMs) die with 2.4 on
> both my Pismo and my G4. It works fine on any 2.2 with the exact same
> overall setup. It dies late (after all driver initialize), with or
> without the r128 driver, with or without aty128fb in the kernel. Black
> screen and no answer to signals. I can kill it remotely (telnet) and I
> can get the screen back by launching Xpmac. I didn't yet manage to figure
> out what's wrong.

Strange, it works fine here running 2.4.0-test4 from linux-pmac-devel...


Michel


--
Man invented language to satisfy his deep need to complain.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
