Date: Tue, 19 Nov 2002 17:48:15 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Unexpected sleep on old iBook
In-Reply-To: <2C5637A6A7CE844EA3C0A94565479F5275A2E2@dest-as20-002.int.bauer-partner.com>
Message-ID: <Pine.LNX.4.33.0211191743560.11419-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > The kernel will never trigger a sleep by itself. Only
> > pmud or pbbuttonsd may. You will want to look at those logs or
> > track an eventual bug in there.
> >
> > Ben.
>
> OK, I'll have a look at the pmud code and come back later.

Please try running pmud with the -s or -S flag (signal init on power low)
and take note of the battery power level readings. I suspect the kernel
does return erroneous power readings on occasion, causing pmud to trigger
sleep. I've not been able to reproduce this on my Lombard Powerbook -
other users (iBook IIRC) report the battery power suddenly dropping to
zero from as much as 80%. I'm currently trying to collect more information
on this new feature.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
