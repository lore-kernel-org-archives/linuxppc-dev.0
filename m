Message-ID: <3BA10447.77751663@mvista.com>
Date: Thu, 13 Sep 2001 15:08:55 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Donovan, Chris" <cdonovan@lanier.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status on 403 (Oak) support
References: <C97ABDA0DC2DD511BA400002A50974132804F1@jdry.lanier.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Donovan, Chris" wrote:

> While searching the archives I found a thread which mentioned that that
> kernel no longer compiles for the 403 processor

Yes, when I merged the latest bunch of 405GP changes I did break
some of the 403 support.  Now that 405 and Walnut are working,
I can apply some patches courtesy of Tivo and Mark Hatle that will
allow 403GCX support again.  Just hang on for a couple of days while
we sort this out again.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
