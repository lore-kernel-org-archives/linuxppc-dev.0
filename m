Subject: HZ in 2.6 on PPC32
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset=UTF-8
Message-Id: <1061654591.1251.34.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 23 Aug 2003 18:03:11 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Why is this still defined to 100? I'm running at 1000 now, and it makes
a huge difference for interactivity. Moreover, CONFIG_PREEMPT now makes
things even better instead of worse. :)

If the reason is the slow PPC32 CPUs still around, maybe make it a
config option?


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
