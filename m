Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel
	on your machine ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Lee Braiden <jel@ntlworld.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040107105437.GA26103@iliana>
References: <20031222134504.GA5964@iliana>
	 <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana>
	 <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana>
	 <1073460144.784.79.camel@gaston> <20040107074740.GB22544@iliana>
	 <1073464206.4416.81.camel@gaston> <20040107095358.GA24780@iliana>
	 <1073472268.4416.104.camel@gaston>  <20040107105437.GA26103@iliana>
Content-Type: text/plain
Message-Id: <1073476057.4416.107.camel@gaston>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 22:47:37 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> So, would it be meaningfull to change all the others to NODEV too ?

You are beeing anal or what ? :)

Who cares about that legacy driver in 2.4 anyway :)

If you really want, I suppose the failure on request_region could
return -EBUSY, not sure about the best error to return from failures
on request_irq...

Nobody really cares about those codes though. At least not in this driver.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
