Return-Path: <hxie@centecnetworks.com>
Received: from mail.centecnetworks.com (unknown [222.92.63.19])
	by ozlabs.org (Postfix) with ESMTP id 2FFBF67A67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 10:00:06 +1000 (EST)
Message-ID: <4249EC0F.1010302@centecnetworks.com>
Date: Wed, 30 Mar 2005 08:00:15 +0800
From: Anchor <hxie@centecnetworks.com>
MIME-Version: 1.0
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
References: <42496C68.60603@centecnetworks.com>
	<424970CD.3030006@smiths-aerospace.com>
In-Reply-To: <424970CD.3030006@smiths-aerospace.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: inuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: how to get a embbed linux for MPC8240 which core is 603e
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:

> Anchor wrote:
>
>> Hi everbody:
>>
>>    I am a new guy, I want get a ready embedded linux for Motorala 
>> ppc8245, give me a hand.
>>
>> Thank you very much!
>>
>> anchor xie
>
>
> CLAP CLap Clap clap
>
> Wolfgang Denk has a very good turn-key system "Embedded Linux 
> Development Kit" (ELDK).  Download it and install it -- it is a very 
> painless way to get started with a cross (or native) development system.
>   <http://denx.de/e/index1.php>
>
> Read the documentation on his site! 
> <http://denx.de/e/index1.php?head=docs-head&main=docs&subnav=docs-subnav&logo=logo-se&mainnav=docsnav&bottom=bottom-se> 
>
>
> ...especially the very useful " DENX Guide to U-Boot and Embedded Linux"
>   <http://www.denx.de/twiki/bin/view/DULG/Manual>
>
> READ the FAQ!  Re-read the FAQ!
>   <http://www.denx.de/twiki/bin/view/DULG/Faq>
>
> If you need a boot loader, u-boot is a very good way to go.
>   <http://sourceforge.net/projects/u-boot>
> (Wolfgang is the maintainer).
>
> gvb
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
Jerry:

thank you very much! but the ELDK only support PPC8XX, PPC6XX, PPC85XX, 
perhaps I need PPC6XX, I want to know, this number is cpu type identify 
or core type Identify?

anchor xie
