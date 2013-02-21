Return-Path: <phileas-fogg@mail.ru>
Received: from smtp23.mail.ru (smtp23.mail.ru [94.100.176.176])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1C4352C02A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 08:06:08 +1100 (EST)
Message-ID: <51269A4B.1020501@mail.ru>
Date: Thu, 21 Feb 2013 23:06:03 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
References: <1360365046.495584377@f356.mail.ru> <5123C729.5040607@mail.ru>
 <5123D864.4060503@mail.ru> <51253558.1070407@mail.ru>
 <1361406741.4676.44.camel@pasglop> <512685B7.5080404@mail.ru>
 <1361478942.4676.53.camel@pasglop>
In-Reply-To: <1361478942.4676.53.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2013-02-21 at 21:38 +0100, Phileas Fogg wrote:
>> The new 8 bytes at offset 0x90 in dt.dump.hex look suspicously like
>> the kernel virtual address: 0xc00000000001a4a0.
>
> It does indeed. What does that address correspond to in the kernel
> text ? Can you disassemble around it with "objdump -D vmlinux" ?
>
> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

Does it look like the new data at offset 0x80 and 0x88 in DT are MSR flags 
MSR_DR, MSR_IR and MSR_EE ?
