Message-Id: <200001201819.NAA25088@mal-ach.watson.ibm.com>
To: Moritz Thomas <motho@gmx.net>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: Re: still no accelerated X ($#!$*)
In-Reply-To: Message from Moritz Thomas <motho@gmx.net>
   of "Wed, 19 Jan 2000 11:38:57 +0100." <l03130300b4ab42c57934@[213.6.57.225]>
Date: Thu, 20 Jan 2000 13:19:48 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Why does each application/library define its own, incorrect
definition of byte-reversed instructions?  Doesn't some Linux/PPC header
file define this once in a awy that could be imported by others?

	One cannot use "r" as a constraint for a base address, that is
what the GCC PowerPC port defines "b" for.  The load/store instruction
patterns in the GCC PowerPC machine description file use a different
constraint letter for the base address, and anyone writing inlined
assembly -- especially loads and stores -- should browse the GCC machine
description.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
