Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
In-Reply-To: <20040118131402.GB5729@iliana>
References: <20040105164038.GA16158@iliana>
	 <1073338095.9497.70.camel@gaston> <20040105214239.GA20252@iliana>
	 <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana>
	 <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana>
	 <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be>
	 <20040118121507.GB4603@iliana>
	 <1074430817.9700.157.camel@thor.asgaard.local>
	 <20040118131402.GB5729@iliana>
Content-Type: text/plain
Message-Id: <1074503545.812.54.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 20:12:25 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-01-19 at 00:14, Sven Luther wrote:

> Using PCI gart only. (No real AGP on this box, only a pci bus faked as
> AGP one.

Makes no sense. It's either an AGP bus or not an AGP bus. AGP is just a
superset of PCI so there is no such thing as "PCI bus faked as AGP one".

> > > What makes me wonder, is that X needs around 20 seconds to launch, which
> > > could not be something normal. It usually takes 5-8 seconds only.
> >
> > DDC timeouts? As Ben pointed out, one can only speculate without seeing
> > the server log.
>
> Maybe, but it worked well with my previous board. See the log in my
> response to Ben.
>
> Friendly,
>
> Sven Luther
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
