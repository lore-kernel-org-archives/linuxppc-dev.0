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
Message-Id: <1085963398.1996.27.camel@gaston>
Mime-Version: 1.0
Date: Mon, 31 May 2004 10:29:58 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Is there any datasheet or similar which describes this chip?


No, I need to manually decode some of the platform-do-* properties in
the device-tree that initialize things properly and implement the
necessary tweaks. That or finally write an interpreter for those ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
