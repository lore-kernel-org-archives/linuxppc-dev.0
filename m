Mime-Version: 1.0
Message-Id: <p05100300b95ea06f444c@[192.168.0.22]>
Date: Sat, 20 Jul 2002 01:10:41 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: old-world boot freeze; 2.4.19-rc2
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just rsynced 2.4.19-rc2 from source.mvista.org (although official
kernel is at rc3?). Built fine, but when I try to boot it on a 9500
with a Powerlogix G3 upgrade, the last two things I see (early in the
boot) are:

setup_arch: enter
setup_arch: bootmem

And then it just locks up.

Any ideas? Last kernel I've been running on this is 2.4.18, with no problems.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
