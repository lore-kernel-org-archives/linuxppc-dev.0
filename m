To: Daris Nevil <Daris.Nevil@snmc.com>
Cc: Steve Rossi <srossi@ccrl.mot.com>,
        Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: e2fsck?
References: <3922A729.F5A922FE@ccrl.mot.com> <veu2fxtdyf.fsf@lipta.cendio.se> <3922B831.E2269E37@snmc.com>
From: Marcus Sundberg <marcus@cendio.se>
Date: 17 May 2000 17:35:04 +0200
In-Reply-To: Daris Nevil's message of "Wed, 17 May 2000 10:18:09 -0500"
Message-ID: <veog65tck7.fsf@lipta.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daris Nevil <Daris.Nevil@snmc.com> writes:

> It seemed that when I ran into problems with e2fsck it was
> because the program was trying to cleanup the filesystem.
> If the filesystem is ok, then e2fsck operates without crashing.

I have successfully fsck'ed dirty ext2 filesystems on 8xx, no
problem there either.

//Marcus
--
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
