Date: Wed, 28 Jan 2004 19:00:43 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Hugang <hugang@soulinfo.com>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	<ncunningham@clear.net.nz>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
In-Reply-To: <20040129010246.43e9bda0@localhost>
Message-ID: <Pine.LNX.4.44.0401281859120.21460-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > OK. I put a mdelay(100) between the PMU_SYSTEM_READY request and the
> > pmu_suspend() call in pmu_sys_resume and it seems to work so far. Side
> > note: if you are saving a large system and have multiple swap files,
> > play with swap priorities to make sure the pages are swapped out to
> > the file_not_ used for suspend.
>
> Can you try with swsusp2 ppc port, if you have time.

I'll have a look at it. Unless you take care of PMU timeouts some way,
I'd dare predict it won't work, though.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
