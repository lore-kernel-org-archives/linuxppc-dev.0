Date: Sun, 18 Jan 2004 23:27:10 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040118222710.GE11651@iliana>
References: <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana> <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be> <20040118121507.GB4603@iliana> <1074430817.9700.157.camel@thor.asgaard.local> <20040118131402.GB5729@iliana> <1074503545.812.54.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074503545.812.54.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 08:12:25PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2004-01-19 at 00:14, Sven Luther wrote:
>
> > Using PCI gart only. (No real AGP on this box, only a pci bus faked as
> > AGP one.
>
> Makes no sense. It's either an AGP bus or not an AGP bus. AGP is just a
> superset of PCI so there is no such thing as "PCI bus faked as AGP one".

It is a PCI bus (well actually, PCI-X could be supported), but it is
not. The connector is an AGP one, and there is some magic chip or
something which you need to access to do AGP-like config accessing. I
have no idea of the details of it though, only that you need to write
the f118/f11c address before/after each agp config space address.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
