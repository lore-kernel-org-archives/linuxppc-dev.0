To: Steve Rossi <srossi@ccrl.mot.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: e2fsck?
References: <3922A729.F5A922FE@ccrl.mot.com> <veu2fxtdyf.fsf@lipta.cendio.se> <3922B831.E2269E37@snmc.com> <veog65tck7.fsf@lipta.cendio.se> <3922C14F.DDC74F6E@ccrl.mot.com>
From: Marcus Sundberg <marcus@cendio.se>
Date: 18 May 2000 10:21:01 +0200
In-Reply-To: Steve Rossi's message of "Wed, 17 May 2000 10:57:03 -0500"
Message-ID: <ve66scmfpu.fsf@lipta.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi <srossi@ccrl.mot.com> writes:

> Well, that seems to be my problem too. I grabed the
> e2fs-progs-1.18 from the debian potato distribution,
> along with the debian patch.
> I'm compiling with gcc-2.95.2 (from the monta vista dev
> kit) on linuxppc on a G4 (yellowdog champion server 1.2
> distribtion). Still I get the same effect. Marcus what is
> different in your configuration?

Well, I cross-compile from an x86 machine using Debian's gcc 2.95.2,
and my kernel is different from yours. Does your kernel contain
the MMU fixes? Otherwise things will go haywire as soon as all your
RAM is used up by e2fsck.

//Marcus
--
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
