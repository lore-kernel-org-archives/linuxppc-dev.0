Message-Id: <200001202009.PAA26168@mal-ach.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Kevin Hendricks <khendricks@ivey.uwo.ca>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Thu, 20 Jan 2000 20:59:06 +0100." <Pine.HPX.4.10.10001202043560.18916-100000@gra-ux1.iram.es>
Date: Thu, 20 Jan 2000 15:08:59 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

Gabriel> I think that it is not necessary: the best thing with a compiler which
Gabriel> performs alias analysis might be to tell the truth

Gabriel> asm ("stwbrx %1,%2,%3"
Gabriel> : "=m" (*(volatile unsigned *)(base_addr+regindex))
Gabriel> : "r" (regdata), "b" (base_addr), "r" (regindex));

Gabriel> Note we don't use %0, and it won't produce any aditional code. You may
Gabriel> want to check what the compiler would have generated as addressing mode
Gabriel> by appending " # %0" at the end of the code string.

	Yes, this type of inlined assembly describing the actual memory
operation as an output constraint is better than clobbering all of memory,
if possible.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
