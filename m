Date: Mon, 2 Jun 2003 10:26:34 +0200
From: Remco Post <r.post@sara.nl>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] A stand-alone boot loader for PReP
Message-Id: <20030602102634.00cdf985.r.post@sara.nl>
In-Reply-To: <20030601221249.GQ32642@plato.local.lan>
References: <62639.213.107.143.228.1054413401.squirrel@www.solinno.co.uk>
	<20030531214950.GP32642@plato.local.lan>
	<63891.213.107.143.228.1054475827.squirrel@www.solinno.co.uk>
	<20030601221249.GQ32642@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 1 Jun 2003 14:12:49 -0800
Ethan Benson <erbenson@alaska.net> wrote:

>
> On Sun, Jun 01, 2003 at 02:57:07PM +0100, Leigh Brown wrote:
> > Unfortunately I think a PReP boot loader is largely orthogonal to an
> > OF based loader. Even PReP boxes that have OF don't support enough
> > services for yaboot (in any form) to work. Most PReP boxes don't have
> > OF or even allow any firmware calls from within the boot loader. With
> > PReP everything you need to bring up the O/S has to be held on the
> > boot partition and loaded into memory at boot time.
>
> then why do you have a of1275 interface in your loader?
>
> basically prep OF is more broken then apple's oldworld? now thats
> impressive...
>

Well, I happen to own a motorola powerstack 2, I don't think there is
anything to do with OF in there....

--
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
