Message-ID: <3AA41B77.73470672@ncal.verio.com>
Date: Mon, 05 Mar 2001 15:04:23 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Pismo Aty128fb problem in 2.4.3-pre*?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wasn't able to boot Kaoru-san's 2.4.3-pre1_0a binary
or kernels built from bitkeeper tar's of 2.4.3-pre1 and pre2.
This is on a Pismo and in all cases there's a sequence of
early boot messages ending in "open_pic exit" and then a few
seconds pause before the screen goes haywire (mostly blank,
but with a flashing fragments of a couple of the boot messages
and some other artifacts).

So, it finally dawned on me that I should try video=ofonly
and novideo bootparms instead of the usual aty128fb parms
and they both boot.

Is this a known problem? Or does 2.4.* require different
video bootparms for the Rage 128 than 2.2.*?

Haven't messed with 2.4 since the late 2.3 period, so I
don't have have anything to compare against to look for
changes. What's the last version of 2.4.* that aty128fb
is known to work, particularly for the Pismo, and are
the sources available somewhere to rsync or as a tarball?

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
