To: linuxppc-dev@lists.linuxppc.org
Subject: Crash with linux-pmac-stable on iMac DV
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Date: 19 Jul 2000 10:11:17 +0200
Message-ID: <m31z0q1qvu.fsf@quimbies.gnus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With the current linux-pmax-stable, with the backport dmasound
patches, my iMac crashes every couple of days with the message:

vector: 400 at pc = eb5c2c44, msr = 40009032, sp = d2949e10 [d2949d60]
current = d2948000, pid = 476, comm = gdmlogin

Is this a known problem?  If not, what can I do to help debug this?

--
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
