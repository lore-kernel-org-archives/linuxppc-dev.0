Date: Thu, 29 Jan 2004 01:02:46 +0800
From: Hugang <hugang@soulinfo.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	<ncunningham@clear.net.nz>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-Id: <20040129010246.43e9bda0@localhost>
In-Reply-To: <Pine.LNX.4.44.0401281707260.21460-100000@opal.biophys.uni-duesseldorf.de>
References: <1075238892.17953.201.camel@gaston>
	<Pine.LNX.4.44.0401281707260.21460-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Jan 2004 17:09:36 +0100 (CET)
Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> wrote:

> OK. I put a mdelay(100) between the PMU_SYSTEM_READY request and the
> pmu_suspend() call in pmu_sys_resume and it seems to work so far. Side
> note: if you are saving a large system and have multiple swap files,
> play with swap priorities to make sure the pages are swapped out to
> the file_not_ used for suspend.

Can you try with swsusp2 ppc port, if you have time.

:)

--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
