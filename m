In-Reply-To: <1068508789.31229.70.camel@gaston>
References: <7AFDCF4E-FCCB-11D6-8F24-003065F22EAA@mindspring.com> <booek6$vvl$1@sea.gmane.org> <1068508789.31229.70.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EE1CD888-1419-11D8-9936-00039382032A@mindspring.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Igal Baevsky <igal.baevsky@terayon.com>
From: Tim Seufert <tas@mindspring.com>
Subject: Re: pmac_halt() bug
Date: Mon, 10 Nov 2003 23:37:40 -0800
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Nov 10, 2003, at 3:59 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2003-11-11 at 03:33, Igal Baevsky wrote:
>
>> Tim,
>> Is there any way to halt PMAC machine with no powering it off ?
>> I will realy appretiate your answer - the problem you mentioned above
>> is
>> the exact problem I'm dealing with .
>> Thanks.
>> Igal
>
> I see no good reason why you want to do such a halt that just spins and
> do nothing but suck power...
>
> If the problem is to have the machine turn back on, I fail to see how
> halting it this way would help. The only thing I can imagine is
> enabling
> the server mode option.

That's precisely it.  Some (all?) pmacs with server mode don't
automatically turn on after an intentional shutdown, only after power
is lost.  So the idea is to have the UPS signal the computer to halt,
and then have the UPS cut power once it's safe.  Later the UPS switches
power back on and the computer will automatically boot.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
