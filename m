To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Jun 2002 14:45:51 PDT."
             <20020620214551.GI16052@opus.bloom.county>
Date: Thu, 20 Jun 2002 23:58:39 +0200
Message-Id: <20020620215844.E66F61030A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020620214551.GI16052@opus.bloom.county> you wrote:
>
> > Isn't this more or less  the  same  idea  as  presented  by  Wolfgang
> > Grandegger more than half a year ago? See
>
> Pretty similar, yeap.
>
> > By then there was a common agreement that it was a bad idea from  the
> > beginning (although we need and use it for RTAI anyway).
>
> Well, Dan Malek didn't like it (and he doesn't like it again either).
> When you did this for RTAI, I assume (since I didn't look at the patch)

Grrrgh.. Why do we send a patch, when you don't even look at it?

> that in the end it was so RTAI wouldn't have to special-case 8xx things
> in the common code (ie request_irq() or cpm_install_handler()) ?

No. It's needed because otherwise you cannot register  a  RT  handler
for CPM interrupts.

> > It's amusing to see how ideas get recycled again and again.
>
> heh.

Well, actually my amusement is limited. This whole business how  some
patches  make  it  or  don't  make  it into some kernel tree is higly
frustrating.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Two wrongs don't make a right, but three rights make a left.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
