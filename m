From: "Chris Backas" <cbackas@rcn.com>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Date: Thu, 13 Jul 2000 01:32:24 -0400 (EDT)
Reply-To: "Chris Backas" <cbackas@bigfoot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: iBook woes
Message-Id: <E13CcDf-0003p2-00@smtp01.mrf.mail.rcn.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I'm having sound & video trouble with my iBook.. before I start, here's the machine's info:

Original iBook, 160MB RAM, modified with a 12GB HD, and it has an AirPort card.  I have a working tri-boot setup with MacOS 9.0.4, Mac OS X DP4, and Yellow Dog Linux
Champion Server 1.2.  I'm using yaBoot to boot the machine (BootX causes it to lockup instantly, and often it simply turns off when I try to use BootX) and as on now, Kernel
is 2.2.17pre10-ben1

First, the video trouble.  Using the version of XFree that came with YellowDog, X runs in 800x600x8, which is very ugly.  After about 15-30minutes of using X, the screen
would polarize and the computer would lock up hard (dead to pings etc).  So, I decided to upgrade to XFree 4, because that was listed as a solution for iMac trouble on
Yellow Dog's page.  I installed XFree 4, and although the lockups are now gone, I have a new (odd) problem.  The left 1/4inch of the image is displayed on the right
1/4inch of the screen =)  (Slightly raised up too)  There's no overlap, the entire screen is shifted to the left like this, and I'm still not able to get anything better than 8bit color.
In XFree's messages, I can see a message indicating that it thinks the video card has 468K of RAM.

Am I missing something obvious?  Do I need a specific video= line in my yaboot.conf file?


Ok, now for the sound.  Simply put, I've never heard a peep out of this thing under Linux.  Is the dmasound module the correct one for the iBook?  I have 'alias sound
dmasound' on /etc/conf.modules, and 'lsmod' lists dmasound as loaded (but unused). When I start X, I can see complaints from esd that /dev/dsp does not exist (it does)
But perhaps it's not setup properly?

There's a few other minor troubles (mainly with making MacOS not unbless my yaboot partition...) but these two ar e the big ones =)  Any help is appreciated.

Chris Backas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
