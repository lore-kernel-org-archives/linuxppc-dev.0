Message-ID: <3D234DA8.E18192F4@wvi.com>
Date: Wed, 03 Jul 2002 12:16:56 -0700
From: Jim Potter <jrp@wvi.com>
Reply-To: jrp@wvi.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel panics running from ramdisk
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm building a ramdisk image for use with my embedded SMP ppc system,
and I'm getting pernicious reoccurring (although seemingly random)
kernel panics:

    Kernel panic: Attempted to kill init!
     <0>Rebooting in 180 seconds..

Sometimes the panics occur when typing the first command, sometimes
several minutes into the session.

My goal is to assemble a flash-based ramdisk image that is a bit more
full-featured than the minimal ones available in various places.  After
copying and stripping various libraries and binaries from a recent YDL
install I've got one that gzips down to around 3meg, and after running
ldd on everything it looks like the libraries are in all the right
places (/lib & /usr/lib).  I'm passing "init=/bin/sh" to the kernel.

Has anyone found a cause for the "Attempted to kill init" panic that
doesn't involve mis-placed (or missing) libraries?  According to ldd
I've got the libraries sorted out.  Thanks, all.

--
Sincerely,

Jim Potter
45th Parallel Processing

 Those that would give up a necessary freedom for
  temporary safety deserve neither freedom nor safety.
    -- Ben Franklin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
