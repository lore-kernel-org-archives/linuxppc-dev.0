Subject: Re: multiple separate pci bridges ...
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
In-Reply-To: <20040118121507.GB4603@iliana>
References: <1073252724.780.5.camel@gaston> <20040104220608.GA1667@iliana>
	 <20040105164038.GA16158@iliana> <1073338095.9497.70.camel@gaston>
	 <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston>
	 <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston>
	 <20040106081143.GA1644@iliana>
	 <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be>
	 <20040118121507.GB4603@iliana>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1074430817.9700.157.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Sun, 18 Jan 2004 14:00:18 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-18 at 13:15, Sven Luther wrote:
>
> Finally, X works, altough DRI freezes after a second or two with my
> radeon 9200SE, while it works for a Radeon 7500, but this is probably a
> DRI issue.

Could also be AGP related.


> What makes me wonder, is that X needs around 20 seconds to launch, which
> could not be something normal. It usually takes 5-8 seconds only.

DDC timeouts? As Ben pointed out, one can only speculate without seeing
the server log.


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
