Subject: Re: pmac_halt() bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Igal Baevsky <igal.baevsky@terayon.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <booek6$vvl$1@sea.gmane.org>
References: <7AFDCF4E-FCCB-11D6-8F24-003065F22EAA@mindspring.com>
	 <booek6$vvl$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1068508789.31229.70.camel@gaston>
Mime-Version: 1.0
Date: Tue, 11 Nov 2003 10:59:50 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-11-11 at 03:33, Igal Baevsky wrote:

> Tim,
> Is there any way to halt PMAC machine with no powering it off ?
> I will realy appretiate your answer - the problem you mentioned above is
> the exact problem I'm dealing with .
> Thanks.
> Igal

I see no good reason why you want to do such a halt that just spins and
do nothing but suck power...

If the problem is to have the machine turn back on, I fail to see how
halting it this way would help. The only thing I can imagine is enabling
the server mode option. I added that feature to my very latest trees
for Core99 machines and later (AGP machines), and there used to be a
tool doing that for CUDA based machines.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
