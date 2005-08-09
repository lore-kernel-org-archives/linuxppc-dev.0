Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <17145.13414.996858.522127@cargo.ozlabs.ibm.com>
References: <17145.13414.996858.522127@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D0475FAC-2E8B-4217-8409-4D0AB61CB9BA@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 9 Aug 2005 18:00:21 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 9, 2005, at 5:55 PM, Paul Mackerras wrote:

> Segher Boessenkool writes:
>
>
>> Yes, and that is exactly what I do not want.  We are not going
>> to require OF implementations that do not need yaboot or similar
>> to pass a flattened device tree to the kernel, eh?  Also, there
>> is no reason why something like yaboot (with an OF still running
>> underneath) should have to care about anything device-tree related
>> at all; the OS can just as easily ask the OF itself.
>>
>
> For now the kernel will cope with either having an OF client interface
> entry point or a flattened device tree passed to it.  In the future we
> intend to move all the OF client calls into the zImage wrapper and
> have the zImage wrapper pass the flattened device tree to the kernel
> proper.  That will be much cleaner because we will be able to get rid
> of all of the dodgy RELOC stuff in prom_init.c.

Can you clarify when the "future" is.  I'd like to see this change  
happen as part of the arch/powerpc work.

- kumar
