Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Rob Baxter <robb@synergymicro.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040107023501.GA16761@iliana>
References: <1073338095.9497.70.camel@gaston>
	 <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston>
	 <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston>
	 <20040106081143.GA1644@iliana>
	 <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be>
	 <20040106144545.GA7261@iliana> <20040106153305.GA6251@synergy>
	 <1073425055.784.3.camel@gaston>  <20040107023501.GA16761@iliana>
Content-Type: text/plain
Message-Id: <1073442982.784.47.camel@gaston>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 13:36:23 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Mmm, ok. I still have to pass it the l2cr=0x80000000 boot arg, but maybe
> it would be easier to add it to the default boot args or something.

No, your platform code can initialize it directly, but CC a flame to
the firmware folks for not doing it right in the first place

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
