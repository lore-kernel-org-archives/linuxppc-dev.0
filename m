Subject: Re: nearly-working support for cpufreq on 2004 iBook G4 with
	7447Acpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>
In-Reply-To: <63605.192.43.227.18.1086055525.squirrel@www.toojays.net>
References: <200405302331.35357.toojays@toojays.net>
	 <200405311003.21439.toojays@toojays.net> <1085975390.1930.31.camel@gaston>
	 <200405311807.59356.toojays@toojays.net> <1086047232.1930.74.camel@gaston>
	 <63605.192.43.227.18.1086055525.squirrel@www.toojays.net>
Content-Type: text/plain
Message-Id: <1086058430.1954.3.camel@gaston>
Mime-Version: 1.0
Date: Tue, 01 Jun 2004 12:53:50 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-06-01 at 12:05, John Steele Scott wrote:
> > Oh, and when switching to high speed, think about tweaking the
> > voltage too. I don't know if it's high or low when setting the
> > GPIO bit, you may want to check out OF code, it certainly have
> > methods for that. Or you can read the voltage value back from
> > the adt themometer chip I think, as it does voltage control.
>
> I will double-check this tonight (am at uni now), but I thought that the
> core voltage for this chip does not change with frequency . . . :(

It probably does since there is a GPIO for controlling it on
KeyLargo. It's not the chip itself that changes it, you use the GPIO
to change it before/after the freq. switch. That's wher the real saving
comes from, more than the freq change itself in fact.

ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
