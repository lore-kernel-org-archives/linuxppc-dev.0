Message-ID: <3926B7A3.F66027C@pop.agri.ch>
Date: Sat, 20 May 2000 18:04:53 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Ethan Benson <erbenson@alaska.net>
CC: Debian-PowerPC <debian-powerpc@lists.debian.org>,
        Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Paul's 2.2.15 does not boot a 7200
References: <20000520002947.A6452@plato.local.lan>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan Benson wrote:
>
> Hi,
>
> I have rsynced paul's stable kernel tree to 2.2.15 proper (no pre),
> this kernel works quite well with a G3 via yaboot, but will not boot a
> 7200 (via quik).  I have tried my own custom config as well as Paul's
> config included in the rsync tree.  quik loads the kernel successfully
> and prints `Copying Device tree' just like it does for 2.2.14 but the
> monitor just stays black and nothing else happens, it never boots any
> further.
>
> the quik used is the current debian quik sources, patched by Dan
> Jacobowitz to support powermacs. (there is no macos on this machine so
> bootx is not an option, nor testable)
>
> has anyone else had problems with 2.2.15 on 7200s?
>
> the system runs Debian potato, and runs paul's 2.2.14.
No problems here, 2.2.15 and pre16-3 vanilla, with bootx(1.2b1). I don't
boot from MESH, I use my adaptec 2940UW. The same with dev kernels...
make pmac_config
make menuconfig (enable some eth dev's, disable parport and dos fs)
make vmlinux
make modules
make modules_install
put it to MacOS, reboot with 2.2.15, it still runs....

I know, not very helpful.

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
