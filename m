Date: Sun, 24 Oct 1999 20:47:40 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: paulus@linuxcare.com, avatar@imaclinux.net
From: BenH <bh40@calva.net>
Subject: iBook/UMA pre2
Message-Id: <19991024204740.022621@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just updated my iBook patches, the PMU shutdown issue is gone (it
was simply not liking the kbd LEDs request, I should have found this one
earlier). I still don't receive CB1 interrupts however and the timer I'm
using may not be safe (I can probably not be sure of MacOS setting on
this timer) and is slow enough to be annoying with the trackpad.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
