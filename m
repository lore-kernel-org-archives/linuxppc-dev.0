Message-Id: <200101161747.MAA22402@mal-ach.watson.ibm.com>
To: Dan Malek <dan@mvista.com>
cc: Ralph Blach <rcblach@raleigh.ibm.com>, frowand@mvista.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel mapping 
In-Reply-To: Message from Dan Malek <dan@mvista.com>
   of "Tue, 16 Jan 2001 11:50:15 EST." <3A647BC7.15F669F3@mvista.com>
Date: Tue, 16 Jan 2001 12:47:16 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Dan Malek writes:

Dan> I have been experimenting with many different methods of using
Dan> the "large" page table sizes through the generic memory management
Dan> methods that already exist in the kernel.  I believe I can wrap
Dan> the concept of the pinned TLB entries into the same logic as BAT
Dan> register management on the bigger processors.  Hence, I call them
Dan> simulated BAT registers....the semantics aren't quite the same.

	Note that forthcoming 64-bit PowerPC chips from IBM utilize
multiple page sizes and no longer provide BAT registers.  "BAT register
management on the bigger processors" is a misnomer.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
