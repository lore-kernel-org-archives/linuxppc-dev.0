Message-ID: <39F96E14.C06AB6FB@mpifr-bonn.mpg.de>
Date: Fri, 27 Oct 2000 13:59:16 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Lombard Sleep Crash (Was: 2.2.18pre17 again)
References: <14839.53124.753011.489351@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The rsync'ed 2.2.18pre17 kernel hangs if I try to wake up my Lombard after a
sleep. Sleeping seems to work (the LED binks), but upon wakeup it just stops
blinking, and nothing else. No reports in /var/log/messages, I just have to
reboot.

I had somewhat similar problems with Ben's 2.2.17pre20-ben3 kernel (however,
this one reported a panic in /var/log/messages), but 2.2.18pre15-ben1 (from
http://penguinppc.org/~olaf/) works fine.

Any ideas?

Thanks in advance, Albrecht.

--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
