Date: Mon, 19 Jan 2004 10:21:27 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040119092127.GA17892@iliana>
References: <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana> <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be> <20040118121507.GB4603@iliana> <1074430817.9700.157.camel@thor.asgaard.local> <20040118131402.GB5729@iliana> <1074503545.812.54.camel@gaston> <20040118222710.GE11651@iliana> <1074466760.4903.58.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074466760.4903.58.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 09:59:20AM +1100, Benjamin Herrenschmidt wrote:
>
> > It is a PCI bus (well actually, PCI-X could be supported), but it is
> > not. The connector is an AGP one, and there is some magic chip or
> > something which you need to access to do AGP-like config accessing. I
> > have no idea of the details of it though, only that you need to write
> > the f118/f11c address before/after each agp config space address.
>
> WTF ? There is no such thing like AGP-like config access... there is
> real AGP cycles but from what you say, it doesn't seem to work.

Yeah, exactly my impression on this. The only thing i was told about
this, is that you have to do this black magic (disable interrupts, write
to f118, do the access, write to f11c, enable interrupts) for each
access to the secondary bus config space.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
