To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Jun 2002 17:49:40 EDT."
             <3D124DF4.6060505@embeddededge.com>
Date: Fri, 21 Jun 2002 00:02:05 +0200
Message-Id: <20020620220210.C233C1030A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D124DF4.6060505@embeddededge.com> Dan Malek wrote:
>
> > Isn't this more or less  the  same  idea  as  presented  by  Wolfgang
> > Grandegger more than half a year ago? See
>
> Yes, it's very similar.  I thought this was just your stuff
> coming from someone else :-)

This is how I see it: we submit a patch, Tom Rini does not even  look
at  it,  it  gets rejected, and half a year later it pops up and "the
bulk of this work was done by" somebody else.

> it ever since :-)  All we get is one hack on top of another without the
> right solution (kinda like the PCI I/O accesses and mapping).

:-(

> > It's amusing to see how ideas get recycled again and again.
>
> Yeah, but the implementation is always slightly different :-)

Well, there is something needed to make "the bulk of this work".

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Technology is dominated by those who manage what they do  not  under-
stand.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
