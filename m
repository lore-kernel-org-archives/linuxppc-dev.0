Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel
	on your machine ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Lee Braiden <jel@ntlworld.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040107074740.GB22544@iliana>
References: <20031217165608.GA11653@iliana>
	 <20031217170620.GS11761@stop.crashing.org> <20031219114050.GA5650@iliana>
	 <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana>
	 <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana>
	 <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana>
	 <1073460144.784.79.camel@gaston>  <20040107074740.GB22544@iliana>
Content-Type: text/plain
Message-Id: <1073464206.4416.81.camel@gaston>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 19:30:06 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  1) could a #ifdef __powerpc__ not be enough ?

No. _machine is only defined for the "multiarch" config (PREP/CHRP/PMAC)

>  2) The other failures in rtc_init return -EIO, not -ENODEV.

Well, in this case, -ENODEV makes more sense, though nothing really
cares except the kind of error message the user will get when using
it as a module.

> Friendly,
>
> Sven Luther
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
