Message-Id: <200001161644.RAA14656@appel.flower>
To: linuxppc-dev@lists.linuxppc.org
Subject: Cutting edge moved or shifting to .deb?
Date: Sun, 16 Jan 2000 17:44:08 +0100
From: Jan Nieuwenhuizen <janneke@gnu.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi List,

Can someone provide us with a list of repositories for cutting edge
.rpm packages?  dev.linuxppc.org should be devel.linuxppc.org, but
apart from Franz Sirl's regular glibc/binutils/gcc/rpm updates (grand!),
not much seems to happen anymore since last September.  There's an 
almost-M12 mozilla, that crashes when I type in an url.  Then, there's
some odd stuff in contrib and updates at ftp.linuxppc.org.

On the other hand, ftp.<cc>.debian.org has stuff such as XFree 3.3.6,
emacs-20.5 (which is good, I was having a lot of trouble with my 20.3
emacs), a recent mozilla-M12, that can be alienised, but the glibc seems
to be 'stuck' at libc6_2.1.2-5.deb. 

Kernel development seems to have moved from vger to openprojects to
Paul's at linuxcare: rsync -auvz linuxcare.com.au::linux-pmac-devel.
I was able to compile and boot the 2.3.39 kernel, with only minor
troubles.  Initially, X (fbdev) comes up with a distorted screen,
but after a circle of zooming (C-M-+), it's fine.  Also, my eth0 (Bmac)
and eth1 (pci) get swapped, which makes for silly network-setup
problems.

On a related, totally off-topic note: I can't seem to find how to
verify package integrity with dpkg, eg, the equivalent for rpm --verify.

I've setup a partition this summer with a minimal debian installation,
just to test it out.  But at that time, I had only low-bandwidth and
deer internet access.  The debian distribution was having quite some
problems then, and updating by burning a cdrom a week didn't really work
for me.  Now I'm using that partition to run compiles on: I removed all
docs and other stuff, so that a lot of packages should be reinstalled.
However, `chroot /mnt/debian/root dpkg --audit', and `dpkg --status
<some-doc-truncated-package>' say all is ok?  How to fix and upgrade
this?

Greetings,

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
