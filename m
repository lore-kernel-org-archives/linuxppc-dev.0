To: Dan Malek <dan@mvista.com>
Cc: Wolfgang Grandegger <wg@denx.de>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Multi-level CPM Interrupts 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 29 Oct 2001 10:01:45 EST."
             <3BDD6F59.7070301@mvista.com>
Date: Wed, 31 Oct 2001 22:19:44 +0100
Message-Id: <20011031211949.C52D411269@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BDD6F59.7070301@mvista.com> Dan Malek wrote:
>
> Wolfgang Grandegger wrote:
...
> > I have incorporated the CPM into the multilevel interrupt structure
> > on the 8xx.
>
> Why?
...
> Why is this good?

It seems you did not real until the end of Wolfgang's message; he wrote:

| it easily allows RTAI users to use CPM interrupts.


We need this for RTAI, and I don't see any problems with it.

> Please leave the 8xx/CPM interrupt stucture alone, and add some /proc

Would you please explain why you think the proposal is bad? ANd  what
is your recommendation for RTAI, then?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It took him several minutes to understand any new idea  put  to  him,
and  this is a very valuable trait in a leader, because anything any-
one is still trying to explain to you after two minutes  is  probably
important  and anything they give up after a mere minute or so is al-
most certainly something they shouldn't have been bothering you  with
in the first place.                   - Terry Pratchett, _Reaper Man_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
