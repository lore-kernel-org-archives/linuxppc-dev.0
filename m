From: Paul Mackerras <paulus@linuxcare.com>
To: Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: my rsync trees
Date: Fri, 26 Nov 1999 16:05:13 +1100
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99112616173402.00490@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Those of you who were having trouble using rsync -z with the rsync trees at
linuxcare.com.au should try again.  The trouble was that that is a Debian
system and the latest debian rsync package got installed.  Some clever
debian maintainer decided that rsync should use the standard zlib, instead
of the extended zlib that comes with rsync. :-)

Currently linuxcare.com.au::linux-pmac-stable is at 2.2.14-pre9, and
linux-pmac-devel is at 2.3.29.  There is a precompiled 2.2.14pre9 kernel
in ftp://linuxcare.com.au/pub/ppclinux/kernels/2.2.14p9/.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
