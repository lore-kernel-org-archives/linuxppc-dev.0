Date: Thu, 27 Jul 2000 21:27:29 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: powerbook hang from post-sleep cdrom access - fix
In-Reply-To: <20000727131240.11712@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10007272123550.19106-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Aye. Can you be more specific about 'do whatever needs to be done'? Can I
> >just send the disk a read command to wake it up? Send a reset
> >command?? Will a reset command hurt if I always send a drive reset
> >there?
>
> I don't know yet ;) I have to look more closely at my ATA spec. It may
> not be necessary to wakeup the disk in fact, the current code seems to be
> ok for the hard disk once the timeout has been bumped.

Except that when the disk has been shut down with hdparm -Y, it needs a
reset and that will only come after quite some number of retries ans
timeouts. Not for the faint of heart :-)

Let me know when you have some code to test. I can test with CD-ROM and
Zip in the media bay as well BTW. Are your current changes in Paul's
stable tree or in the bk stable only? Six rsync trees is a bit much for me
to manage :-)

XFree86 related PCI resource diff follows separate.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
