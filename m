Message-Id: <199909221253.IAA27717@picard.cs.ohiou.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
In-Reply-To: <19990922110700.018164@mailhost.mipsys.com> 
Reply-To: ostermann@cs.ohiou.edu
From: "Shawn Ostermann" <ostermann@cs.ohiou.edu>
cc: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PB3400 ethernet and Q1->Q3 upgrade 
Date: Wed, 22 Sep 1999 08:53:28 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




> From: Benjamin Herrenschmidt <bh40@calva.net>
> 
> I'll hack a test interrupt handler for the DEC chip cascaded on this
> second ohare (at first, I'll simply put all the code in the dec driver,
> and later I'll fix all this up like I did for the wallstreet if
> necessary, but with only the ethernet using this interrupt, this may not
> be useful).

Lots of people are asking to get the modem working too (although it's
only 33.6), so it would be nice if we could get that supported.  I'm
hoping it will be a trivial change to whatever you're able to come up
with for the ethernet.

Thanks again for your help!

Shawn "The User" Ostermann
-------------------------------------------------------------------------
   Dr. Shawn Ostermann  -  Associate Professor  -  Ohio University
      140 Morton Hall, Ohio University, Athens, Ohio  45701-2979
 ostermann@cs.ohiou.edu -- FAX: (740)593-0406 -- Voice: (740)593-1242
    http://ace.cs.ohiou.edu/~osterman   http://jarok.cs.ohiou.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
