Subject: Re: [PATCH] Workaround for 745x data corruption bug
From: Adrian Cox <adrian@humboldt.co.uk>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Brian Waite <linwoes@gmail.com>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <4111231E.5040201@mvista.com>
References: <1091291276.987.57.camel@localhost>
	 <410E85EE.8050707@mvista.com> <36b714c804080306175c5dc3f6@mail.gmail.com>
	 <411009D9.7090802@mvista.com> <36b714c8040804073721d8d856@mail.gmail.com>
	 <4111231E.5040201@mvista.com>
Content-Type: text/plain
Message-Id: <1091651964.4549.6.camel@newt>
Mime-Version: 1.0
Date: Wed, 04 Aug 2004 21:39:24 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-08-04 at 18:55, Mark A. Greer wrote:
> 1) M=1 is only necessary in an SMP environment (or for the 745x erratum).

And the reason we have to turn it on for the MPC10x bridges is that they
contain their own cache. Even though it only has two cache lines, it has
to be treated as a second processor for coherence purposes.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
