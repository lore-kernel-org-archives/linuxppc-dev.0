Message-ID: <3922C14F.DDC74F6E@ccrl.mot.com>
Date: Wed, 17 May 2000 10:57:03 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Marcus Sundberg <marcus@cendio.se>,
        Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: e2fsck?
References: <3922A729.F5A922FE@ccrl.mot.com> <veu2fxtdyf.fsf@lipta.cendio.se> <3922B831.E2269E37@snmc.com> <veog65tck7.fsf@lipta.cendio.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, that seems to be my problem too. I grabed the
e2fs-progs-1.18 from the debian potato distribution,
along with the debian patch.
I'm compiling with gcc-2.95.2 (from the monta vista dev
kit) on linuxppc on a G4 (yellowdog champion server 1.2
distribtion). Still I get the same effect. Marcus what is
different in your configuration?

Steve


Marcus Sundberg wrote:

> Daris Nevil <Daris.Nevil@snmc.com> writes:
>
> > It seemed that when I ran into problems with e2fsck it was
> > because the program was trying to cleanup the filesystem.
> > If the filesystem is ok, then e2fsck operates without crashing.
>
> I have successfully fsck'ed dirty ext2 filesystems on 8xx, no
> problem there either.
>
> //Marcus
> --
> -------------------------------+-----------------------------------
>         Marcus Sundberg        |       Phone: +46 707 452062
>   Embedded Systems Consultant  |      Email: marcus@cendio.se
>        Cendio Systems AB       |       http://www.cendio.com

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
