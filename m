Message-ID: <3BD82D8A.F0DC3B77@mvista.com>
Date: Thu, 25 Oct 2001 11:19:38 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Okehee Goh <ogoh@asu.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU in MBX860
References: <AEEDJHMEPHBIHBAHOOCDIELKCAAA.ogoh@asu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Okehee Goh wrote:

>  The problem is that it shares one global page table between kernel and
> application processes.

You can support any type of memory mapping and protection you wish using a
combination of features supported by the 8xx MMU and standard operating
system mapping techniques.  What you are asking to do isn't difficult, but
asking us to design your system for you in a reasonable period of time
isn't likely to happen on this mailing list :-).

Good Luck.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
