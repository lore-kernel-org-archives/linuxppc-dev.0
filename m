Subject: Re: PPC405GP: Spurious interrupt during handing level triggered
	interrupts
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: "listmember@orkun.us" <listmember@orkun.us>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <33774.216.110.51.8.1078964058.squirrel@www.orkun.us>
References: <16763.216.110.51.8.1078873137.squirrel@www.orkun.us>
	 <1078936213.16427.27.camel@spawn.uab.ericsson.se>
	 <33774.216.110.51.8.1078964058.squirrel@www.orkun.us>
Content-Type: text/plain
Message-Id: <1079025214.16429.32.camel@spawn.uab.ericsson.se>
Mime-Version: 1.0
Date: Thu, 11 Mar 2004 18:13:35 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-03-11 at 01:14, listmember@orkun.us wrote:
> Kenneth,
>

> However, I think, code could be enhanced to reset the SR bit, "only" for
> level triggered interrupts and leave edge triggered interrupts alone. This
> would require looking at UIC0_TR register as well.

Yes If you could do a patch for this for level triggered only it would
be good. I can't see this affecting anything negative so it should be no
problem getting it integrated.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
