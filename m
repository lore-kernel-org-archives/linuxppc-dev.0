Message-ID: <41075FE3.1040008@fh-landshut.de>
Date: Wed, 28 Jul 2004 10:12:19 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: Linh Dang <linh@linhdang.home>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BAT mapping exported to user-space
References: <10A74DE9-DFF7-11D8-96F8-003065F9B7DC@embeddededge.com> <wn58yd5p7og.fsf@linhd-2.ca.nortel.com>
In-Reply-To: <wn58yd5p7og.fsf@linhd-2.ca.nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Linh Dang wrote:
> Dan Malek <dan@embeddededge.com> wrote:
>
>>On Jul 27, 2004, at 1:34 PM, Dang, Linh [CAR:2X23:EXCH] wrote:
>>
>>>>cat /proc/ppc_htab
>>>
>>>PTE Hash Table Information
>>
>>You misunderstand. This is the PPC Hash table, not Linux PTEs. There
>>are lots and lots and lots of Linux PTEs are are eventually loaded
>>into the PPC hash table for the processor to fetch.
>
> Thanx for pointing that out. I have to dig further. I guess it would
> come down to how much pressure using pages for mapping our asics
> (instead of BATs) would have on the TLBs.

Maybe you want to have a look at the book "Understanding the Linux Virtual
Memory Manager". Though clearly not PowerPC-specific (as always this book, too,
focuses on the x86), it's a recommended buy for understanding how paging etc.
works with Linux. It does explain the non-architecture-specific part rather
thoroughly.

Then, together with the "Programming Environments Manual For 32-Bit
Implementations of the PowerPC Architecture" (from Motorola), this
should give you a good understanding of what's going on, and how Linux
is handling this stuff.

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
