Message-ID: <3A9559FE.8813D9DC@intel.com>
Date: Thu, 22 Feb 2001 10:27:10 -0800
From: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Still problems with embedded Linux
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm still having problems with getting my embedded Linux system
operational.

If I use the Montavista root filesystem, init asks me for a runlevel and
then just
sits there. I've searched the mailing lists for this, and I saw two
reports, but
no replies.

So I decided to strip everything: I'm booting into a FS that uses devfs,
has libc
and ncurses, bash and busybox, using busybox as the init. I compiled
busybox
0.49 myself. Here's where it gets very interesting: booting without a
inittab
file works, as busybox has a default. So I tried using a minimal 2 line
inittab,
and it wouldn't work. But if I used a one line inittab that would start
up bash,
it works. Once I'm on the shell, I can't read any text files but for
that one line
inittab. If I have a larger inittab and boot straight into bash, I can't
cat it either.

This sounds too much like libc problems. Can anybody help me?

--
[]'s Bruno Renato Barreyra
bruno.r.barreyra@ufl.edu
barreyra@ufl.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
