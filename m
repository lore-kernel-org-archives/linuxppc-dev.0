Message-Id: <200112070759.IAA00984@piglet.grunz.lu>
Date: Fri, 7 Dec 2001 08:59:14 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: NVRAM stuck in DST?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

For some time now (in fact since going back from summer time to winter
time), my PowerMac 7500 gains one hour at very system boot. No matter
how I configure it to save sytsem time as GMT or as localtime in the
RTC, I _always_ get +1 hour on boot.

I've looked at kernel messages, and it says there:

...
GMT Delta read from XPRAM: 120 minutes, DST: on
...

Hmmm... DST on? That's wrong; we're not in DST anymore! And the current
offset to GMT is one hour, not two hours. I'm wondering whether
something else besides MacOS sets those values.

If not, then I'll be stuck with whatever NVRAM values MacOS wrote there
when it was last booted. Which means that unless at every DST time
change, unless I bot MacOS once, I'll be stuck with the wrong time....

Also, just for my understanding, doesn't MacOS save the system time in
the RTC in localtime? In that case I don't see how time _advances_ on
boot... unless the MacOS RTC is in DST-less localtime.

Anybody with more insight here?

Thanks, and cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
