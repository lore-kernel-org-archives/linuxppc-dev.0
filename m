To: linuxppc-dev@lists.linuxppc.org
Subject: Sleep broken on iBook 2.2 since test7-benh
From: Michael Shields <shields@msrl.com>
Date: Fri, 31 Oct 2003 18:08:17 +0000
Message-ID: <87brrxfffy.fsf@mulligatwani.msrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sometime between test7 and yesterday, the linuxppc-2.5-benh tree has
stopped sleeping on my iBook 2.2.  It blanks the screen but does not
actually suspend.  It cannot be woken up from this state; I have to
use control-command-power.

The config I'm using is at:
http://www.msrl.com/~shields/config-2.6.0-test9

I've tried disabling CPU frequency scaling, since there were recently
problems with that, and I've also tried backing out changeset 1.1180,
which provides an additional delay when sleeping (there was already
one below it, which I've left in).  I didn't immediately see anything
else that looked like it might cause problems.
--
Shields.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
