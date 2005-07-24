Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id ED22167C5A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 00:29:50 +1000 (EST)
In-Reply-To: <20050723215913.GA777@electric-eye.fr.zoreil.com>
References: <20050723215913.GA777@electric-eye.fr.zoreil.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2A1209AF-773C-4F35-8A85-887257A2EA64@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Sun, 24 Jul 2005 09:20:50 -0500
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH RFC]: PHY Abstraction Layer III
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Because the patch is all new code.  drivers/net/phy/phy.c doesn't  
exist in any kernel tree.  The patch is adding it.

- kumar

On Jul 23, 2005, at 4:59 PM, Francois Romieu wrote:

> Andy Fleming <afleming@freescale.com> :
>
>> Here's the latest version of the patch, done against a cogito
>> linux-2.6 branch.
>>
>
> The patch includes a diff against drivers/net/phy/phy.c which does not
> seem to exist in my -rc3-git4 local tree. Where can it be found ?
>
> --
> Ueimor
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
