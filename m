From: "Chris Backas" <cbackas@rcn.com>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Date: Fri, 14 Jul 2000 18:28:40 -0400 (EDT)
Reply-To: "Chris Backas" <cbackas@bigfoot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: iBook woes: Update
Message-Id: <E13DEYW-0000Ee-00@smtp01.mrf.mail.rcn.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

Well, I've gotten pretty much everything working nicely on my iBook now.

The video problem I was having is solved in later kernels.  The kernel that comes with YellowDog won't boot successfully unless I set video to none in my yaboot.conf file
- it hard locks.  As of the 2.2.17 series, this is no longer true.  Now you *have* to set the mode to 10 and the color depth to 32 (well, I don't think the color depth HAS to be 32,
but why not go for it? =) )

With 2.2.17pre10-ben1, this makes XFree work well, but the full screen text consoles are messed up - they bleed weird colors and don't update correctly.  However, after
updating to the very very latest yaBoot (0.7) and kernel (2.2.17pre10-ben2) , both I believe were released today (7/14/2000) all my video trouble has vanished.  The full
screen consoles work fine again, and XFree is centered on screen, at 24bit color, and 800x600.

The 2.2.17 kernels have also fixed networking problems - previously my network performance was sporadic, it would transfer a few hundred K very quickly, then 'play
dead' for upwards of 20 seconds, and it would also transfer files with CRC errors on occasion.  None of this is true in the 2.2.17 series =)  My OpenFirmware Boot Menu
recognizes the Linux partition now too, so I can boot between MacOS, MacOSX and Linux by just holding the option key!

So, I guess my only remaining iBook wishes are sound, and an Accelerated XServer.  But, I'm happy for now.  The Airport driver was a nice bonus as well ;)

I've gotta give a special thanks to Ben H. here, for yaBoot, the AirPort driver, and his 'special' kernel patches that seem to make all the difference.  Great job!

Chris Backas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
