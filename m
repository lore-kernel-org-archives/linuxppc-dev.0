Date: Wed, 7 Jan 2004 11:34:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Lee Braiden <jel@ntlworld.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20040107183441.GA12082@stop.crashing.org>
References: <20031219114050.GA5650@iliana> <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana> <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana> <1073460144.784.79.camel@gaston> <20040107074740.GB22544@iliana> <1073464206.4416.81.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1073464206.4416.81.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 07, 2004 at 07:30:06PM +1100, Benjamin Herrenschmidt wrote:
>
> >  1) could a #ifdef __powerpc__ not be enough ?
>
> No. _machine is only defined for the "multiarch" config (PREP/CHRP/PMAC)

Technically it's '0' on !CONFIG_ALL_PPC, but (for the sake of fullness)
I don't know if ppc64 defines __powerpc__ :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
