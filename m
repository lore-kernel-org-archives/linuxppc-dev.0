To: Dean Matsen <deanmatsen@earthlink.net>
Cc: Stephan Linke <Stephan.Linke@epygi.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: parallel I/O ports & opend darin pins on MPC8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Jul 2003 12:25:00 PDT."
             <3F0C6C0C.8040306@earthlink.net>
Date: Wed, 09 Jul 2003 21:57:14 +0200
Message-Id: <20030709195719.9BBF5C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F0C6C0C.8040306@earthlink.net> you wrote:
>
> >Solution? What is so difficult about latching your output value in  a
> >variable?
> >
> What he's saying is that OTHER drivers read the input and then write
> that value to the output.

I did understand this.

> In his driver, he can latch the output through a variable, but that
> won't affect what other

Obviously all drivers that may modify bits in this I/O port will have
to share the variable used to latch the value.

Yes, this may include modifying existing code in the UART or Ethernet
or other drivers.

> Unless there is kernel support to alias the data in a memory variable
> (and it doesn't sound like
> there is), then this is going to continue to be a problem.  Might I

Don't make it unnecessary complicated. You don't need "kernel support
to alias the data in a  memory  variable".  This  is  really  not  so
difficult to implement yourself when you need it.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The so-called "desktop metaphor" of today's workstations  is  instead
an  "airplane-seat"  metaphor.  Anyone who has shuffled a lap full of
papers while seated between two portly passengers will recognize  the
difference -- one can see only a very few things at once.
                                                   - Fred Brooks, Jr.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
