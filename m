Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
In-Reply-To: <20040118222710.GE11651@iliana>
References: <20040105214239.GA20252@iliana>
	 <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana>
	 <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana>
	 <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be>
	 <20040118121507.GB4603@iliana>
	 <1074430817.9700.157.camel@thor.asgaard.local>
	 <20040118131402.GB5729@iliana> <1074503545.812.54.camel@gaston>
	 <20040118222710.GE11651@iliana>
Content-Type: text/plain
Message-Id: <1074466760.4903.58.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 09:59:20 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> It is a PCI bus (well actually, PCI-X could be supported), but it is
> not. The connector is an AGP one, and there is some magic chip or
> something which you need to access to do AGP-like config accessing. I
> have no idea of the details of it though, only that you need to write
> the f118/f11c address before/after each agp config space address.

WTF ? There is no such thing like AGP-like config access... there is
real AGP cycles but from what you say, it doesn't seem to work.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
