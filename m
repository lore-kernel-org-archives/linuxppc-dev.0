Date: Fri, 07 Mar 2003 09:57:17 -0800
From: Ira Weiny <iweiny@acm.org>
Subject: Upgrade Blues 2.4.20 Ben H kernel
To: linuxppc-dev@lists.linuxppc.org
Message-id: <20030307095717.1b1bece1.iweiny@acm.org>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well I decided it was time to get up to date on my TiBook.

So I went out and bought a copy of Yellow Dog and got apt-get installed and
started hacking.  After some switching pain I got it up and running but found
that I needed a newer kernel to get the networking stuff to work.

no problem...  I rsync'ed Bens tree built and rebooted...

There are 2 problems.

1) My Microdrive which I had hacked in does not work any more.  What is the
   status of the ide-cs driver?  Anyone know?  It is different than when I got
   it to work before and I am not sure where to begin again.

2) m3mirror does not work?  This one really puzzles me.  lcd:0 turns off the
   LCD screen but crt:1 does not turn on the outside monitor.  I rebooted into
   Mac OS and the external port works.  The only thing I can think of is that I
   did use the S-video port on Mac OS to show some pictures.  Is there
   something in OF which Mac OS would set which would make the external port
   not work with m3mirror?

Relative versions
2.4.20-ben5

> cat /proc/cpuinfo
cpu		: 7410, altivec supported
temperature 	: 10-12 C (uncalibrated)
clock		: 500MHz
revision	: 17.3 (pvr 800c 1103)
bogomips	: 996.14
machine		: PowerBook3,2
motherboard	: PowerBook3,2 MacRISC2 MacRISC Power Macintosh
detected as	: 71 (PowerBook Titanium)
pmac flags	: 0000000b
L2 cache	: 1024K unified
memory		: 512MB
pmac-generation	: NewWorld

> cat /proc/fb
0 ATY Rage128

As usual broken and hacking my kernel...  ;-)
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
