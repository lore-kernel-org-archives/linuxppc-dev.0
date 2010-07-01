Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46F15B6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 12:46:31 +1000 (EST)
In-Reply-To: <20100701090546.0b7406ee.sfr@canb.auug.org.au>
References: <20100630160422.3087bdf0.sfr@canb.auug.org.au>
	<B6229BDC-F290-4A71-9F61-AAA5EC87F0F6@kernel.crashing.org>
	<20100701082756.7dced805.sfr@canb.auug.org.au>
	<4D7DE8D9-B226-4C6A-97FF-A63D272681C5@kernel.crashing.org>
	<20100701090546.0b7406ee.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5E01E5D4-762C-4B5C-A14C-FA45C0815180@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix compile errors in prom_init_check for gcc 4.5
Date: Thu, 1 Jul 2010 04:46:26 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> See http://patchwork.ozlabs.org/patch/57379/ submitted yesterday.
>>
>> Yeah saw that right after I hit "send" :-)  Either it's way more
>> complete than what I did, or way more complex because we still
>> don't link with libgcc :-P
>
> Actually, the 64bit versions of the routines are supplied by the  
> linker,
> so the vmlinux links fine.  But for modules, the final link is  
> actually
> done by the kernel module loader, thus we need to provide those  
> routines
> in this case.  linking against libgcc would not have helped.

Right, so "more complete" it is :-)

I now checked that patch in detail, and it looks good to me.  Thank
you for tackling this!


Segher
