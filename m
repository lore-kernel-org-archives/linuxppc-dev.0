From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: David Edelsohn <dje@watson.ibm.com>, Moritz Thomas <motho@gmx.net>
Subject: Re: still no accelerated X ($#!$*)
Date: Thu, 20 Jan 2000 13:25:40 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
References: <200001201819.NAA25088@mal-ach.watson.ibm.com>
In-Reply-To: <200001201819.NAA25088@mal-ach.watson.ibm.com>
MIME-Version: 1.0
Message-Id: <00012013281100.00851@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Thanks for your reply.

> Why does each application/library define its own, incorrect
> definition of byte-reversed instructions?  Doesn't some Linux/PPC header
> file define this once in a awy that could be imported by others?

I could not find one.  I will look again.

> 	One cannot use "r" as a constraint for a base address, that is
> what the GCC PowerPC port defines "b" for.  The load/store instruction
> patterns in the GCC PowerPC machine description file use a different
> constraint letter for the base address, and anyone writing inlined
> assembly -- especially loads and stores -- should browse the GCC machine
> description.

Thanks I will as soon as I find it ;-).  But the assembler generated was exactly
the same in my simple test case.  Is this just luck?

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
