Date: Thu, 09 Mar 2000 16:47:17 +0000
From: David Riley <happyoscar42@usa.net>
Subject: kernel.org kernels and unreliability
To: linuxppc-dev@lists.linuxppc.org
Reply-to: happyoscar42@usa.net
Message-id: <38C7D58F.C8970B7E@usa.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone else noticed unreliable memory problems using kernel.org's
2.3.x kernels?  Especially while compiling, random things start
happening (more specifically, I get random page faults, signal 11
terminations of cc1 and bits of code are randomly dropped which reappear
when I restart compiling), but I have also noticed that any large files
that I download over ftp (and probably other protocols) have pieces
dropped from them.  At first I blamed this on the ethernet card on the
other end (I have an FTP server running on a K6-2 linux box that says
"eth0: tx interrupt but no status"), but MacOS downloads perfectly from
it, and it has no problem receiving.  I would use paul's kernel source,
but my PPP connenction runs behind a firewall which blocks out almost
every port (which includes Quake*, rsync, and sometimes even http when
the operators screw up) and I woun't get my DSL line until June. ;-(  I
know I could use the tarballs of Paul's kernel source, but it's easy to
download a small patch every update than a 10-12 MB tarball over a PPP link.

If it makes a difference, I'm running on a 7300 (604e, hammerhead memory
controller) and this has been happening since kernel 2.3.42 (when I
upgraded from vger-2.3.18) and includes kernel 2.3.50 which hardly works
on i386 (it breaks , among other things, xfs, so I can't run X) as well.

--
"Your mouse has been moved.  Windows 95 must be restarted for change to
take effect."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
