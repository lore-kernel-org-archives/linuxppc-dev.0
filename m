Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel, rc1 and rc2 problem.
Date: Wed, 20 Nov 2002 12:55:01 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLKECJFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20021119190116.13369.qmail@web20104.mail.yahoo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I upgraded my linuxppc_2_4_devel from pre8(1.1130) to rc1(1.1157) and noticed that
may syslog had problems to start:

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (jffs2 filesystem).
Freeing unused kernel memory: 64k init
INIT: version 2.78 booting
Fast boot, no file system check
none on /dev/shm type shm (rw)
ramfs on /tmp type ramfs (rw)
ramfs on /var/run type ramfs (rw)
ramfs on /tftpboot/log type ramfs (rw)
Cleaning: /etc/network/ifstate.
Enabling packet forwarding: done.
Disable TCP/IP Explicit Congestion Notification: done.
Configuring network interfaces: done.
Cleaning: /tmp /var/lock /var/run.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd/etc/rc.d/rc2.d/S10syslog: line 53:    50 Ter
minated              start-stop-daemon -v --start --quiet --exec /sbin/syslogd -
- $SYSLOGD
 klogd.
Starting internet superserver: inetd.

I then tried rc2(BK curr) and got the same problem. I am running a custom mpc860 board.

Anyone else noticed this?

   Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
