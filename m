Subject: Re: 405LP RTC reset
From: Hollis Blanchard <hollis@austin.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20021218211556.GA8947@zax.zax>
References: <1040150612.10740.111.camel@granite.austin.ibm.com>
	<20021218005542.GC3666@zax.zax>
	<1040225939.29647.11.camel@granite.austin.ibm.com>
	<20021218211556.GA8947@zax.zax>
Date: 18 Dec 2002 15:49:46 -0600
Message-Id: <1040248187.30597.47.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2002-12-18 at 15:15, David Gibson wrote:
> On Wed, Dec 18, 2002 at 09:38:53AM -0600, Hollis Blanchard wrote:
> >
> > The only issue I can think of here is the firmware setting it
> > incorrectly or not at all. In that case, a few seconds will be expanded
> > or compressed, but that's better than time running too fast or slow
> > forever, right?
>
> That's true.  Still, I think it might be worth testing what the rate
> is set to when we come in, and printing a warning if it's not what we
> expect before we adjust it.  If it just silently corrects it I could
> imagine it being pretty nasty to track down why the device is
> losing/gaining time each boot.

Sounds like a very good idea. I'll add it to my list unless someone
beats me to it. :)

-Hollis
--
PowerPC Linux
IBM Linux Technology Center

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
