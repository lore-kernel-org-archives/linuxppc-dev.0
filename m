Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugang <hugang@soulinfo.com>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	ncunningham@clear.net.nz,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040129010246.43e9bda0@localhost>
References: <1075238892.17953.201.camel@gaston>
	 <Pine.LNX.4.44.0401281707260.21460-100000@opal.biophys.uni-duesseldorf.de>
	 <20040129010246.43e9bda0@localhost>
Content-Type: text/plain
Message-Id: <1075327006.30622.301.camel@gaston>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 08:56:47 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-01-29 at 04:02, Hugang wrote:
> On Wed, 28 Jan 2004 17:09:36 +0100 (CET)
> Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> wrote:
>
> > OK. I put a mdelay(100) between the PMU_SYSTEM_READY request and the
> > pmu_suspend() call in pmu_sys_resume and it seems to work so far. Side
> > note: if you are saving a large system and have multiple swap files,
> > play with swap priorities to make sure the pages are swapped out to
> > the file_not_ used for suspend.
>
> Can you try with swsusp2 ppc port, if you have time.

Well, I though you would do it :) The basis is the same, only the
page copy routine in the assembly has to change afaik...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
