Date: Wed, 28 Jun 2000 08:22:05 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
Reply-To: guinan@bluebutton.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: MBX IDE
Message-ID: <Pine.LNX.4.21.0006280808460.16924-100000@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There was a thread back in November about getting IDE going on
an MBX,

http://lists.linuxppc.org/listarcs/linuxppc-embedded/199911/msg00054.html

Did anyone make any progress on this?  Meaning, is there a recent
kernel with working IDE-on-MBX.  I know its an oddball combination,
but I just wanted to check.

With a few tweaks to MontaVista 2.2.13, I get as far as seeing,

W82C105: IDE controller on PCI bus 00 dev 19
W82C105: not 100% native mode: will probe irqs later
SL82C105 command word: 5
IDE timing: 00000909, resetting to PIO0 timing
SL82C105 command word: 5
IDE timing: 000003e4, resetting to PIO0 timing

but the drive never gets detected in ide_scan_devices(), indirectly
because all of ide_hwifs[x].present are set to 0 (I'm in the middle
of tracing this back: ide_hwifs[x].noprobe fields set to 1 seem to be
preventing ide_hwfs[x].present getting set).

If anyone has a console dump of a working IDE-on-MBX, I'd like
to see it just to know what to expect.

And should I continue tweaking 2.2.13 or try 2.4.0-pre? (opinions)

Thanks,
-Jamie

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
