To: "Mark Chambers" <mwchambers@citlink.net>
Cc: "Gerrit Van de Velde" <gvd@denayer.wenk.be>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Motorola 5200 MIPS 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 03 May 2004 10:39:20 EDT."
             <002101c4311c$6ca7d440$0301a8c0@chuck2>
Date: Mon, 03 May 2004 17:32:59 +0200
Message-Id: <20040503153304.34906C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <002101c4311c$6ca7d440$0301a8c0@chuck2> you wrote:
>
> OK, I know I'm anal-retentive, but I can't just accept "it has 'bogo' in the
> name, so therefore it means nothing."  We've run linux on several 8xx family

Then go back and read the archives. This has been  discussed  several
times before.

> parts and the bogomips closely tracked the expected performance of 1
> instruction/clock.  Now all of a sudden it doesn't mean anything?  So I

It never meant anything.

You can compare values  within  the  same  processor  family,  i.  e.
MPC8xx, but not across different families which may use - for example
- a completely different bus interface.

> P.S. I'm a fan of Motorola processors, hope I didn't sound too ugly.  What
> would the world be like if Bill had chosen the 68000???

There would be a so-called "operating system" which  was  to  be  68k
compatible and full of bugs ;-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The ideal situation is to have massive computing power right at home.
Something that dims the streetlights and shrinks the picture  on  the
neighbours' TVs when you boot it up.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
