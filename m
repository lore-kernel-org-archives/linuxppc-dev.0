Subject: Re: fan control: therm_pm72 on _new_ powermacs 64 ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: boris <boris@macbeth.rhoen.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040816161526.GA3869@macbeth.rhoen.de>
References: <20040805123304.GA18674@macbeth.rhoen.de>
	 <1091779721.9271.218.camel@gaston> <20040816161526.GA3869@macbeth.rhoen.de>
Content-Type: text/plain
Message-Id: <1092702799.9529.74.camel@gaston>
Mime-Version: 1.0
Date: Tue, 17 Aug 2004 10:33:20 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-08-17 at 02:15, boris wrote:
> On Fri, Aug 06, 2004 at 06:08:41PM +1000, Benjamin Herrenschmidt wrote:
>
> > >  Is someone working on linux support for the new fan control unit built in
> > >  recent pmac64 ? Or has further details ?
>
> > You mean the latest G5s ? not yet, as soon as I get the hardware hopefully
>
> It looks like apple released the source (opendarwin) for the new cooling
> system: PowerMac7_3_CPUCoolingCtrlLoop.cpp (AppleMacRISC4PE-125.2.2)!
>
> Is there an easy way to use this code to get the cooling system working
> in linux ?

Possibly, though it's the high level control loop, it lacks the low
level driver, I'll have to figure that one out in different ways. I'm
waiting for one of these models (already ordered), so I'll work on that
as soon as I get it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
