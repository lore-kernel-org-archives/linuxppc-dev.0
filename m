Date: Wed, 7 Jan 2004 03:40:52 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Rob Baxter <robb@synergymicro.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040107024052.GC16761@iliana>
References: <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana> <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be> <20040106144545.GA7261@iliana> <20040106153305.GA6251@synergy> <1073425055.784.3.camel@gaston> <20040107023501.GA16761@iliana> <1073442982.784.47.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1073442982.784.47.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 07, 2004 at 01:36:23PM +1100, Benjamin Herrenschmidt wrote:
>
> > Mmm, ok. I still have to pass it the l2cr=0x80000000 boot arg, but maybe
> > it would be easier to add it to the default boot args or something.
>
> No, your platform code can initialize it directly, but CC a flame to
> the firmware folks for not doing it right in the first place

Ok, i will, thanks again for your help.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
