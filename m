Message-Id: <199908292028.WAA00305@piglet.cpu.lu>
Date: Sun, 29 Aug 1999 22:28:38 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Zero Pages / Cache Coherency
To: apc@agelectronics.co.uk
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37C65FF0.A5FBD535@agelectronics.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  27 Aug, this message from Adrian Cox echoed through cyberspace:
> 
> I'm currently trying out the pre-zeroing of pages in the idle task, and
> I'm a little worried about its effect on cache-coherency. I can't prove
> to
> my satisfaction that none of the pages being cleared by zero_paged() is
> in the cache, and I'm not sure that turning off caching in the PTE will
> have any effect on cache lines already allocated in L1 or L2.

Cort Dougan had a paper about memory management in Linux on the PowerPC
online at NMT, but at this time the link is broken
(http://www.cs.nmt.edu/~cort/papers/linuxppc-mm/). If I remeber right,
he also spoke about zeroing pegaes in the idle task.

Cort, are you among us? What's up with your personal pages?

> Obviously, any incoherency would be extremely rare, but ensuring that
> the page is invalidated from the caches before it is zeroed has the
> added bonus of removing the need for a flush_page_to_ram() in my
> modified anonymous memory allocator.

I can't remeber whether Cort also treated this subject.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
