Message-Id: <200003141133.LAA09460@hyperion.valhalla.net>
Date: Tue, 14 Mar 2000 11:28:49 +0000
Subject: 2.3.51 Trashes RTC on Beige G3 Mini-tower
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

at boot time {with options vmode=atyfb, vmode:16,code:32 single }
the usual "rtc time is" ... prints the correct date...
then we get "setting time to ... some time in Feb 1932...
from then on the RTC is wrong although using 'date' to set the correct time
behaves as expected on the running system.
Is this a library problem? (I'm using 2.3.51 with a system installed from
linuxPPC Q3 - but I've also updated to glibc-2.1.3 - j).

also the caps-lock is set on (although this may have no relevance - and
works perfectly OK afterwards).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
