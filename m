Date: Sun, 18 Jan 2004 14:14:02 +0100
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040118131402.GB5729@iliana>
References: <20040105164038.GA16158@iliana> <1073338095.9497.70.camel@gaston> <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana> <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be> <20040118121507.GB4603@iliana> <1074430817.9700.157.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074430817.9700.157.camel@thor.asgaard.local>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 18, 2004 at 02:00:18PM +0100, Michel Dänzer wrote:
> On Sun, 2004-01-18 at 13:15, Sven Luther wrote:
> >
> > Finally, X works, altough DRI freezes after a second or two with my
> > radeon 9200SE, while it works for a Radeon 7500, but this is probably a
> > DRI issue.
>
> Could also be AGP related.

Using PCI gart only. (No real AGP on this box, only a pci bus faked as
AGP one.

> > What makes me wonder, is that X needs around 20 seconds to launch, which
> > could not be something normal. It usually takes 5-8 seconds only.
>
> DDC timeouts? As Ben pointed out, one can only speculate without seeing
> the server log.

Maybe, but it worked well with my previous board. See the log in my
response to Ben.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
