Mime-Version: 1.0
Message-Id: <p04330100b7f7f805ef9a@[24.163.33.28]>
Date: Sun, 21 Oct 2001 00:02:12 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: 2.4.13-pre5 crash when mounting proc
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


6500, Linux/PPC 2KQ4 running 2.2.19, I compiled 2.4.13-pre5, rsynced
from bk yesterday. On boot, when it gets to "mounting proc
filesystem," I get a break into the mon debugger, but I have no
keyboard response (so no backtrace). The info I can copy is:

vector: 300 at pc = c02432fc lr = c00544e0 msr = b032 sp = c5dc3ef0

plus some more that I'm not sure will help much. For this output
alone, should I include System.map also?


Is this a known problem?


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
