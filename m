Date: Tue, 22 Aug 2000 09:25:23 +0900 (JST)
Message-Id: <20000822.092523.730553082.t-matsuu@protein.osaka-u.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Subject: BMAC works wrong?
From: MATSUURA Takanori <t-matsuu@protein.osaka-u.ac.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm now using PowerMac G3 DT/233 with linux-2.2.17pre18.

Since 2.2.15pre15 or so, hosts over eth0 (BMAC) are suddenly
unreachable several times per day. When eth0 is unreachable, the load
average of this machine is high.

If I'm lucky, I can type the following commands.
$ su -
# ifdown eth0
# ifup eth0
And then, eth0 is recovered. But sometimes I cannot type any commands.

eth1 (via-rhine) has no problem. Users over eth1 tell me eth0 is
unreachable when he/she accesses the sites with low network response.

Is BMAC driver something broken?


MATSUURA Takanori @ Division of Protein Chemistry,
                     Institute for Protein Research, Osaka University, Japan
E-Mail: t-matsuu@protein.osaka-u.ac.jp
Web Page: http://www.protein.osaka-u.ac.jp/chemistry/matsuura/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
