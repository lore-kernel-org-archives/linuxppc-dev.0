Date: Wed, 8 Nov 2000 21:35:39 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
cc: paulus@linuxcare.com.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <39F96E14.C06AB6FB@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.10011082109150.31984-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The rsync'ed 2.2.18pre17 kernel hangs if I try to wake up my Lombard after a
> sleep. Sleeping seems to work (the LED binks), but upon wakeup it just stops
> blinking, and nothing else. No reports in /var/log/messages, I just have to
> reboot.

To follow up on this: 2.2.18pre18 does not freeze on sleep or wakeup on my
Lombard (no CD in drive, CD in drive, CD mounted, regardless).

It does freeze, however, when I snooze the machine while using software
cursor. Seems the software cursor interrupt needs to be stopped before
turning off the display :-) Question: is software cursor support worth the
hassle?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
