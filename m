Date: Mon, 3 Jan 2000 12:27:09 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Andreas Tobler <toa@pop.agri.ch>
cc: Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm-m68k/setup.h in setup.h
In-Reply-To: <386B6101.BDCEC7B3@pop.agri.ch>
Message-ID: <Pine.LNX.4.10.10001031221310.15311-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I'm playing with buildkernel from http://www.pobox.com/~wstearns/buildkernel/
> That is a 'program' which should make it easy to build a kernel. I have
> to find out......
> 
> Now this script removes all other archs from the kernel tree. Especially
> the asm-m68k in the include directory.
> When building the kernel it fails because asm-m68k/setup.h is not available.

That's what you get for using 'smart' tools. Complain to the buildkernel
author, please. 

> I saw that asm-ppc/setup.h includes this file. 
> In asm-ppc/setup.h m68k_num_memory and m68k_memory are defined. These
> two are declared extern in asm-m68k. 
> Are there other things needed from asm-m68k/setup.h?

There will be a lot of other things needed even from arch/m68k if you want
to build kernels for the APUS PPC upgrades for Amigas. The m68k_num_memory
and m68k_memory variables should only be included in the PPC build if
support for APUS is configured though. The APUS people have a separate 

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
