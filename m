Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Pavel Machek <pavel@ucw.cz>, Hugang <hugang@soulinfo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	ncunningham@clear.net.nz,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.44.0401271400530.5220-100000@zirkon.biophys.uni-duesseldorf.de>
References: 
	 <Pine.LNX.4.44.0401271400530.5220-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain
Message-Id: <1075238892.17953.201.camel@gaston>
Mime-Version: 1.0
Date: Wed, 28 Jan 2004 08:40:00 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Battery requests might have been underway; pmud is running. If I read
> pmu_suspend() right, pending battery requests should result in pmu_suspend
> waiting for them to finish?

Normally yes... pmud isn't running at this point (all processes are frozen)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
