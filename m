To: Steve Rossi <srossi@ccrl.mot.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: e2fsck?
References: <3922A729.F5A922FE@ccrl.mot.com>
From: Marcus Sundberg <marcus@cendio.se>
Date: 17 May 2000 17:04:56 +0200
In-Reply-To: Steve Rossi's message of "Wed, 17 May 2000 09:05:29 -0500"
Message-ID: <veu2fxtdyf.fsf@lipta.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi <srossi@ccrl.mot.com> writes:

> Has anyone successfully compiled e2fsck for 8xx? I was able to compile
> it and run it, but it seg faults with the following output:
>
> sh-2.03# e2fsck /dev/sda2
> e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> /dev/sda2 contains a file system with errors, check forced.
> Pass 1: Checking inodes, blocks, and sizes
> Segmentation fault

I had no problems with e2fsck on 8xx. I use the Debian Potato
sources for all packages I build for 8xx, and most of them work
just fine out of the box.

//Marcus
--
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
