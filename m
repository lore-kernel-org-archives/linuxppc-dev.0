Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 24 Oct 2002 15:28:50 -0500
Subject: Re: PPC 405 port complains about 'tlbwe' opcode
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v546)
Cc: <linuxppc-embedded@lists.linuxppc.org>
To: Prakash kanthi <pkanthi@yahoo.com>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <20021024201830.21273.qmail@web14602.mail.yahoo.com>
Message-Id: <348359E2-E78F-11D6-A3F7-003065BFB10E@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You need to pass down to the assembler an option to enable 403/405
instructions.  Add a -Wa,-m405 to the gcc line.

- kumar

On Thursday, October 24, 2002, at 03:18  PM, Prakash kanthi wrote:

>
> Hi There,
>
> I am in the process of porting linux-2.4.18 with
> ppc-patch-2.4.18 to make a 405 linux os. For 'make
> bzImage' it complains about 'tlbwe' being Unrecognied
> opcode from head_4xx.S.
>
> -------
> powerpc-eabi-gcc -D__ASSEMBLY__ -D__KERNEL__
> -I/root/ppctest/linux/include -c -o head_4xx.o
> head_4xx.S
> head_4xx.S: Assember messages:
> head_4xx.S:111: Error: Unrecognized opcode: `tlbwe`
> head_4xx.S:112: Error: Unrecognized opcode: `tlbwe`
> make[1]: *** [head_4xx.o] Error 1
> -------
>
> I saw couple of postings saying that 'tlbwe' is not a
> 405 opcode. But it is defined by PPC-405 manual. I am
> not sure what WS value should be, if i have to add
> 'tlbwe' to supported opcodes.
>
> Please suggest. If you can share a PPC-405 port for
> linux or any other embedded free OS, please let me
> know.
>
> thanks in advance,
> Prakash
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
