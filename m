Message-ID: <B25E2E5A003CD311B61E00902778AF2A02044644@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Dan Malek'" <dan@mvista.com>, Gabriel Paubert <paubert@iram.es>
Cc: Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: dcache BUG()
Date: Mon, 7 May 2001 18:53:10 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been running with Gabriel's suggested patch for about an hour now, and
I still see the problem.  It hasn't generated an Oops in dcache.h yet, but I
do still see the 'de_put: entry net already free!' messages.

I'll let it run overnight to see if the oops occurs.

Brian

-----Original Message-----
From: Dan Malek [mailto:dan@mvista.com]
Sent: Monday, May 07, 2001 6:44 PM
To: Gabriel Paubert
Cc: Eli Chen; Brian Kuschak; linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()


Gabriel Paubert wrote:

> I'm myself more and more convinced myself that this is really a bug,

I'm convinced, too, so thanks for the suggestion.  I think it is
much more likely to show up on the 4xx because of my (assumed)
implementation than on other processors that attempt to make some
use of the EA in the instructions.

> .... It does not fix Eli's problems, so
> either my patch is wrong or something else is going on.

We have many people testing on a variety of systems, so we will
know more shortly.

Thanks again.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
