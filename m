Subject: Re: Making only part of memory DMA-able [CONFIG_DISCONTIGMEM?]
From: Adrian Cox <adrian@humboldt.co.uk>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <5E0FB922-2FB1-11D7-9939-0003931C2BFA@control.lth.se>
References: <5E0FB922-2FB1-11D7-9939-0003931C2BFA@control.lth.se>
Content-Type: text/plain
Date: 24 Jan 2003 16:14:43 +0000
Message-Id: <1043424894.782.17.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-01-24 at 15:34, Anders Blomdell wrote:

> Is there anybody working on DISCONTIGOUS memory allocation for PowerPC's,
> that could shed some light on what should be done? A lot of memory
> management seems to be specialized for CONFIG_440, which further clutters
> my vision...

I've dealt with a very similar system architecture^(1). The main lesson
I learned from this was to always use a non-transparent PCI-PCI bridge.

In your case, I presume that this is a fixed system design, and you
don't have to make every device driver in the Linux kernel work. You
might consider writing a special purpose allocator and modifying the
individual drivers you require to use it.


(1: http://www.varisys.co.uk/tpe3.html )

--
Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
