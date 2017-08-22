Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xc0Kh3MgWzDqXn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 16:00:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: 32-bit powerpc, aty128fb: vmap allocation for size 135168 failed
In-Reply-To: <alpine.LRH.2.20.1708190007310.26479@math.ut.ee>
References: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
 <87mv6xjc2g.fsf@concordia.ellerman.id.au>
 <alpine.LRH.2.20.1708190007310.26479@math.ut.ee>
Date: Tue, 22 Aug 2017 16:00:55 +1000
Message-ID: <87a82sb0q0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Meelis Roos <mroos@linux.ee> writes:

>> Meelis Roos <mroos@linux.ee> writes:
>> 
>> > I was trying 4.13.0-rc5-00075-gac9a40905a61 on my PowerMac G4 with 1G 
>> > RAM and after some time of sddm respawning and X trying to restart, 
>> > dmesg is full of messages about vmap allocation failures.
>> 
>> Did it just start happening? ie. did rc4 work?
>
> It goes back to at least 4.0 - that's the oldest kernel I had laying 
> around precompiled. The messages about ROM signature changed somewehere 
> between 4.0 and 4.7 (4.7 is already like 4.13) but after some time, the 
> same vmalloc errors appear.
>
> Maybe the userspace has changed with more respawning that brings the 
> problem out.
>
> I tried to read the code but I do not understand it yet. The warning 
> seems to come from generic pci_map_rom() checking ROM size, and 
> returning rom pointer to aty128fb (it returns resource size too but that 
> is ignored). aty128fb starts to look at the x86 PCI ROM signature again 
> but does not tell that the signature is missing. How come?

OK thanks. Unfortunately I can't really help on the graphics side of
things. Hopefully someone on Cc has more clues than me.

cheers
