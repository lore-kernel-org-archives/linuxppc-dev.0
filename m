From: christopher.murtagh@wcg.mcgill.ca
Date: Thu, 15 Feb 2001 15:34:19 -0500 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mmu_context_overflow
In-Reply-To: <3A8C11E7.D0CA22F9@mvista.com>
Message-ID: <Pine.LNX.4.21.0102151523330.3305-100000@saraswati.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 15 Feb 2001, Dan Malek wrote:
>Geert Uytterhoeven wrote:
>>
>> I found this in my kernel message log:
>>
>> | mmu_context_overflow
>>
>> running 2.4.1 from January 31 on a CHRP LongTrail with 604e.
>
>I'm assuming this occurred just once.  It's really no big deal
>(except it is a one-time overhead to invalidate all contexts).
>If it continues to happen, let me know and I'll ask for more
>system information.

 I just saw this message for the first time on one of my machines (G4/450)
as well. I've been getting a lot of 'eth0: transmit timed out, resetting'
which would freeze the network in kernel 2.2.17 (I'm now running 2.2.18,
which seems to survive it). My machine is taking on about 120,000 http
requests per hour though and there doesn't seem to be any effect on the
performance. Is this something I should worry about?

 Any info would be much appreciated.

Cheers,

Chris

http://www.mcgill.ca/secretaboutbox/
--

Christopher Murtagh
Webmaster / Web Communications Group
McGill University
Montreal, Quebec
Canada


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
