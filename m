Content-Type: text/plain;
  charset="us-ascii"
From: Srini Amble <samble@xopnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Timer library in Linux
Date: Fri, 21 Mar 2003 09:53:31 -0600
MIME-Version: 1.0
Message-Id: <200303210953.31463.samble@xopnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am looking for a timers library in Linux (create, start, stop, and delete).
On timeout the timer initiator will be notified via some signalling. The
granularity of the timer is at least 10 ms. The "setitimer" is limited to
three timer creation per process which is a limitation for what we are trying
to do. Any pointer is much appreciated.

Srini Amble


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
