Date: Wed, 28 Jul 1999 12:16:10 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: kevyn@mail.apple.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Wallstreet sleep, second try
Message-Id: <19990728121610.027921@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've made a little bit more progress regarding sleep on the wallstreet
powerbooks. It's still not working (crashing on wakeup), but the sleep
code seems ok (the ROM reset code now always correctly detect the fact
that the machine went to sleep and never reboots when waking up).

I've been unable to find a way to debug the wakeup for now (I tried
writing things on screen since the external monitor is back as soon as
the machine wakes up and I tried sending things to the SCC, without much
success neither).

If you want to play with the code and eventually find out what's going
on, the curent patches against 2.2.10 are at:
<http://calvaweb.calvacom.fr/bh40/sleep_test2.tar.gz>. You need to have
xmon compiled into your kernel.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
