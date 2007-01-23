Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B75BDDDF27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 03:19:31 +1100 (EST)
In-Reply-To: <20070123091802.95605193.benjamin.zores@alcatel-lucent.fr>
References: <20070122181027.89187533.benjamin.zores@alcatel-lucent.fr>
	<3B008FD0-DF55-492B-A60A-EF0F9F8F75AB@kernel.crashing.org>
	<20070123091802.95605193.benjamin.zores@alcatel-lucent.fr>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E856EB0C-D2B9-41CA-8F75-3B1A0F60AC7B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [MPC8349ITX] USB Init with PPC arch
Date: Tue, 23 Jan 2007 10:18:34 -0600
To: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 23, 2007, at 2:18 AM, Benjamin Zores wrote:

> On Mon, 22 Jan 2007 16:19:06 -0600
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>> What are these features?
>
> External RT patch that only supports PPC arch atm.
> Also I've encountered some stability issues with PowerPC branch
> (card hangs after some time for undetermined reason).

Do you get an oops on the hang?  would be useful to know if we have  
an issue in arch/powerpc

>> If you are forward porting the Freescale patches and not using the in
>> kernel driver that would explain the issue.  There are bugs in the
>> Freescale driver that have been fixed in the driver that is in the
>> kernel.
>
> I only ported what needs to be i.e. the platform initialization part.
> I'm using the regular USB drivers (EHCI-FSL) from vanilla 2.6.19,  
> this part
> hasn't be ported from old 2.6.13 BSP code (which would have been  
> useless).
>
> The goal of the patch i've sent early is to init the USB bus the  
> same way
> it is done by OF device tree in arch/powerpc/sysdev/fsl_soc.c (but  
> for PPC).
>
> Does it sounds ok to you ?

that sounds reasonable.

Take a look at this patch from Randy Vinson that adds support to arch/ 
ppc for USB.

http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021773.html

- k
