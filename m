Subject: Re: pmac_halt() bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tim Seufert <tas@mindspring.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Igal Baevsky <igal.baevsky@terayon.com>
In-Reply-To: <EE1CD888-1419-11D8-9936-00039382032A@mindspring.com>
References: <7AFDCF4E-FCCB-11D6-8F24-003065F22EAA@mindspring.com>
	 <booek6$vvl$1@sea.gmane.org> <1068508789.31229.70.camel@gaston>
	 <EE1CD888-1419-11D8-9936-00039382032A@mindspring.com>
Content-Type: text/plain
Message-Id: <1068539125.13038.87.camel@gaston>
Mime-Version: 1.0
Date: Tue, 11 Nov 2003 19:25:25 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> That's precisely it.  Some (all?) pmacs with server mode don't
> automatically turn on after an intentional shutdown, only after power
> is lost.  So the idea is to have the UPS signal the computer to halt,
> and then have the UPS cut power once it's safe.  Later the UPS switches
> power back on and the computer will automatically boot.

Ok, 2 things:

- How does the UPS knows it's "safe" ?
- And right, I need to disable server mode to be able to shut down :) So
I indeed to that on those machines

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
