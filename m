Subject: Re: nearly-working support for cpufreq on 2004 iBook G4 with 7447A
	cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>
In-Reply-To: <1085956980.9638.17.camel@gaston>
References: <200405302331.35357.toojays@toojays.net>
	 <1085956980.9638.17.camel@gaston>
Content-Type: text/plain
Message-Id: <1085957029.9638.19.camel@gaston>
Mime-Version: 1.0
Date: Mon, 31 May 2004 08:43:49 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-05-31 at 08:43, Benjamin Herrenschmidt wrote:

> > Does anyone have any ideas on why this might not work on my system? Is there
> > something else that needs to be looked at when increasing the frequency after
> > booting?
>
> You might need the proper clock chip tweaks.

Oh, and you may have the voltage wrong too. I'll have a look

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
