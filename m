Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1074468194.9699.209.camel@thor.asgaard.local>
References: <20040118144412.GA6897@iliana> <1074503490.4547.52.camel@gaston>
	 <1074468194.9699.209.camel@thor.asgaard.local>
Content-Type: text/plain
Message-Id: <1074469340.4547.71.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 10:42:21 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Only the 3D drivers use the IRQ, it's not involved when moving around
> windows. Or do you mean a badly configured IRQ causing a flood or
> something?

Oh, you don't use the IRQ for throttling the ring ? Only for VBL ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
