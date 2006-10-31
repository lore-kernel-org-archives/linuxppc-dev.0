Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F17E367D08
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 16:30:14 +1100 (EST)
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D263314@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D263314@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <58EAF2FD-1812-45C8-A042-9009EC7BFF49@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
Date: Mon, 30 Oct 2006 23:30:07 -0600
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 30, 2006, at 11:25 PM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Tuesday, October 31, 2006 1:06 PM
>> To: Li Yang-r58472
>> Cc: Paul Mackerras; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
>>
>>
>> On Oct 30, 2006, at 8:56 PM, Li Yang-r58472 wrote:
>>
>>>>>> I'm confused, if there are other users of immrbar_virt_to_phy()
> how
>>>>>> can you get ride of it completely?
>>>>>
>>>>> Other users will change to use iopa() instead.  There was some bug
>>> to
>>>>> use iopa() with io_block_mapping area, but it is ok to use it now.
>>>>
>>>> Hmm, what are the other users doing?  I think we should avoid using
>>>> iopa.
>>>
>>> Get physical address from virtual address.  I have considered to use
>>> virt_to_phys(), but it is not consistent between ppc and powerpc
> arch.
>>
>> Why does that matter, qe support only exists in powerpc.
>
> Well, it does use include/asm-ppc/io.h instead of
> include/asm-powerpc/io.h for now.  If the hack is removed, the driver
> will not work.

What uses asm-ppc/io.h instead of asm-powerpc/io.h?

- k
