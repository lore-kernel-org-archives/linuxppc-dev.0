Message-ID: <3AF74F69.95BFC195@mvista.com>
Date: Mon, 07 May 2001 21:44:09 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: Eli Chen <eli@routefree.com>, brian.kuschak@skystream.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105080200190.22253-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
