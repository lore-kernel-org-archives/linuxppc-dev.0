Subject: Re: USB, 2.6-test11 and hot flaming death
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031204163433.GA21236@ibrium.se>
References: <1070080961.683.26.camel@gaston>
	 <09B6571B-2408-11D8-970C-0003939E069A@mac.com>
	 <20031204163433.GA21236@ibrium.se>
Content-Type: text/plain
Message-Id: <1070580925.613.7.camel@gaston>
Mime-Version: 1.0
Date: Fri, 05 Dec 2003 10:35:26 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> This problem has actually been present quite a while (at least
> since 2.6.0-test3). On my dual 1.25 GHz G4, it occurs once
> every four boots or so.

Interesting. It happens with the NEC EHCI/OHCI or with the
KeyLargo OHCI's ? I suspect it's a problem of the NEC part,
and I think K2 actually contains that part built-in on the G5

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
