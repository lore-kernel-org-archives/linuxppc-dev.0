Message-ID: <38D1EDE5.E0FDF042@csem.ch>
Date: Fri, 17 Mar 2000 09:33:41 +0100
From: Amre El-Hoiydi <amre.el-hoiydi@csem.ch>
MIME-Version: 1.0
To: Eisenzopf Thomas <thomas.eisenzopf@siemens.at>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problems with PPC860/ADS
 board/8xxrom-0.3.0/mpc8xx-2.2.13/patches(from Raphael Bossek)
References: <D53137D1F3DDD211A3750800060DA31301702339@viee122a.erd.siemens.at>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I successfully applied the patches
http://master.debian.org/~bossekr/powerpc/patch-2.2.13-mpc8xx.diff.gz
http://master.debian.org/~bossekr/powerpc/patch-2.2.13-mpc8xx-damm.diff.gz
to the kernel
linux-2.2.13.tgz from www.ch.kernel.org/pub/linux/kernel/v2.2/
using the following procedure:

cd linux-2.2.13; patch -p1 [--dry-run] < patch-2.2.13-mpc8xx.diff.gz
cd linux-2.2.13; patch -p1 < patch-2.2.13-mpc8xx.diff.gz

cd linux-2.2.13; patch -p1 [--dry-run] < patch-2.2.13-mpc8xx-damm.diff
cd linux-2.2.13; patch -p1  < patch-2.2.13-mpc8xx-damm.diff
-modify the main Makefile: ARCH := ppc, CROSS_COMPILE = powerpc-linux-
-make config, make dep, make zImage

I could not run it on my FADS board because I have only 4 MBytes memory. I am
using this kernel on a custom board with 16 MBytes memory. I had to do a few
modifications for that.

Is there ? Where is the "low-memory patch" that make the kernel 2.2.13 runable
with only 4
Mbytes memory ?

Regs,

Amre



Eisenzopf Thomas wrote:
>
> Hello!
>
> I´m trying to get embedded Linux running on an ADS board with a PowerPC 860.
>
> For the beginning I used the informations from Raphael Bossek´s WWW-page
> http://www.s4l.de/powerpc.html.
>
> My main problem at this time is, that the patches (from Magnus Damm and
> Raphael Bossek) from this internet page do not seem to fit to
> mpc8xx-2.2.13.tgz; the dates of the files differ, and the patch program
> delivers errors (e.g. Hunk #1 FAILED at 459....). But without these patches
> I cannot build the system.
>
> Does anyone have some advice for me? Is there somewhere a complete archive
> of the needed files (including the patches)? Where can I get additional
> information?
>
> Thank you in advance,
> Thomas.
>

--
C       Amre El-Hoiydi, R&D Engineer,  amre.el-hoiydi@csem.ch
S       System Engineering, Real-Time Software and Networking
E       CSEM, Neuchatel, Switzerland   -   http://www.csem.ch
M       Phone: +41(032)720 5188     -   Fax: +41(032)720 5720

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
