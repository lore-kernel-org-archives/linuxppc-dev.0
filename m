Date: Mon, 16 Aug 2004 18:15:26 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: fan control: therm_pm72 on _new_ powermacs 64 ?
Message-ID: <20040816161526.GA3869@macbeth.rhoen.de>
References: <20040805123304.GA18674@macbeth.rhoen.de> <1091779721.9271.218.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091779721.9271.218.camel@gaston>
From: boris <boris@macbeth.rhoen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 06, 2004 at 06:08:41PM +1000, Benjamin Herrenschmidt wrote:

> >  Is someone working on linux support for the new fan control unit built in
> >  recent pmac64 ? Or has further details ?

> You mean the latest G5s ? not yet, as soon as I get the hardware hopefully

It looks like apple released the source (opendarwin) for the new cooling
system: PowerMac7_3_CPUCoolingCtrlLoop.cpp (AppleMacRISC4PE-125.2.2)!

Is there an easy way to use this code to get the cooling system working
in linux ?

                   mfg
		              boris


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
