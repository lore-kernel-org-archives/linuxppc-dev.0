Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30C2F68AB3
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Feb 2006 02:00:42 +1100 (EST)
In-Reply-To: <20060208124045.GA14370@suse.de>
References: <20060208093439.GA9240@suse.de>
	<20060208211600.28252f22.sfr@canb.auug.org.au>
	<20060208124045.GA14370@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <335AACC0-4227-4D0F-9B4B-2B89F1368ECB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-powerpc/highmem.h missing
Date: Wed, 8 Feb 2006 09:00:39 -0600
To: Olaf Hering <olh@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2006, at 6:40 AM, Olaf Hering wrote:

>  On Wed, Feb 08, Stephen Rothwell wrote:
>
>> On Wed, 8 Feb 2006 10:34:39 +0100 Olaf Hering <olh@suse.de> wrote:
>>>
>>>
>>> Why was asm-ppc/highmem.h not migrated? linux/highmem.h and  
>>> pagemap.h wants it.
>>
>> I guess it was not migrated because it is only required for  
>> CONFIG_HIGHMEM
>> and, of course, ppc64 does not need HIGHMEM and presumably noone  
>> has tried
>> to build with CONFIG_HIGHMEM set in ARCH=powerpc until now.
>
> zaptel wants it as well, via netdevice.h/skbuff.h. I wonder why 32bit
> compiles anyway, given the many users of linux/highmem.h. Looking...
>
>
>
>
> Argh, still these hacks:
>
> lrwxrwxrwx  1 olaf users 64 2006-02-04 13:16 arch/powerpc/include/ 
> asm ->
> /home/olaf/kernel/olh/ppc64/linux-2.6.16-rc2-olh/include/asm-ppc/
>
> So better move it over quick.

You do realize there are a slew of headers in include/asm-ppc/ that  
we use in the arch/powerpc builds for ppc32.

- kumar
