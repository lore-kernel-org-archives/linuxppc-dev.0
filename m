Message-ID: <388CE816.DA8DC406@ctam.com.au>
Date: Tue, 25 Jan 2000 11:02:30 +1100
From: Brendan John Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
CC: dony <dony.he@huawei.com.cn>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile dynamic apps for mpc860 on ix86
References: <200001240802.JAA26827@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> > > Make sure the shell you are running is statically linked!
> >
> > Not needed. Both my shell (sash) and my test app can run dynamically.
>
> Then what do you complain  about  segmentation  faults  when  running
> dynamically linked applications???

I think you are confusing Dony and myself.  Dony has got his dynamic binaries going but I am still having problems.  I am about to
compile ALL my tools again.  binutils-2.9.5.0.24, egcs-1.1.2, glibc-2.1.2.  Hopefully I can get gcc-2.95.2 going at some stage but
this is a lower concern at the moment.


> Ok, once more in detail:
>
> 1. Get your PPC target running with the root filesystem mounted  over
>    NFS with a known set of working tools (shell, libraries, ...). For
>    instance, you can start with the files from the `mbxroot.full.tgz'
>    tarball.

I should try this, but I wanted to steer away from the libc-1.99.  I have no technical reason for this but Dan Malek mentions that
he compiles most things statically.  This requires lots of memory and filesystem space.  I assumed from his statements that linking
dynmaically was not advisable or doesn't work.  This must be false as the mbxroot-min.tgz files are dynamically linked.

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
