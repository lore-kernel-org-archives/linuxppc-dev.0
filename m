Subject: Re: nearly-working support for cpufreq on 2004 iBook G4 with 7447A
	cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>
In-Reply-To: <200405311003.21439.toojays@toojays.net>
References: <200405302331.35357.toojays@toojays.net>
	 <1085956980.9638.17.camel@gaston>  <200405311003.21439.toojays@toojays.net>
Content-Type: text/plain
Message-Id: <1085975390.1930.31.camel@gaston>
Mime-Version: 1.0
Date: Mon, 31 May 2004 13:49:51 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-05-31 at 10:32, John Steele Scott wrote:
>
> On Mon, 31 May 2004 08:13 am, Benjamin Herrenschmidt wrote:
> > OF is probably not reporting wrong frrequency, check your bogomips. I
> > suspect your clock chip isn't configured properly at boot, like with
> > other newer models. I need to hack the proper bits in. I'll have a look
> > at this asap.

Ok, that's weird, I don't see the same kind of clock chip on i2c as
the previous model had... Can you check the exact dividers programmed
on the CPU and redo the calculation based on the bus frequency ?

There is a do-clock-spreading property attached to the U2 ASIC, I don't
know if it may be related, I'll have a look.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
