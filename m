Message-ID: <959692822.3933c01681fde@rascal.ums.easynet.net>
Date: Tue, 30 May 2000 14:20:22 +0100
To: linuxppc-dev@lists.linuxppc.org
From: "Simon Stapleton" <simon@tufty.co.uk>
Subject: Wallstreet Ethernet followup.
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, it's more of a data point, really.

In order to hook up my new DAT drive to the laptop, it had
become necessary for me to get a new kernel.  Rather than
grabbing precompiled ones at random, I'd rather compile my
own, and so I grabbed a copy of the 2.2.15 sources from
Paul's site.

Compiled up, my CD burner and DAT now work with the
wallstreet and, to my surprise, ethernet performance appears
to be fine.  I suspect there are still problems, as
the 'collision' light on my hub still fires up every now
and then, but speed is up from 50kbits/sec to about 9Mbits.
This is good.  Not only that, I couldn't crash the powerbook
anymore, even with multiple FTP sessions in and out and
another kernel compile going (plus X, plus xmms, plus gnome,
plus 2 mesa demos - the mesa stuff did get a bit choppy, tho ;-)

So.  It would appear that one of the following things helps
(this is what I've done recently since I last tried any ftps
off the box)

Downgrade OS from 9.0x to 8.6 (including drivers)
Upgrade to latest BootX
Upgrade from 2.2.14preX to 2.2.15

But I'm not sure which.

Now all I need to do is patch in the volume button stuff, up
the max MESH speed to 10Megs/sec and I'm back on form.
I am a happy bunny.

Simon

--
Your mouse has moved.  You must reboot Windows NT for these changes to be
recognised.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
