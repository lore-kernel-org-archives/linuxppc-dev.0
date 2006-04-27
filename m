Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA9EE67A06
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:59:20 +1000 (EST)
In-Reply-To: <20060427194055.3EED1353A57@atlas.denx.de>
References: <20060427194055.3EED1353A57@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7BC50BA2-D657-4907-94AA-DB5926F22504@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim 
Date: Thu, 27 Apr 2006 14:59:15 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> How would we distinguish the bootm command that takes a blob versus
>> the ones we have today?
>
> Arg count. For example:
>
> OLD:	bootm <kernel_addr>
>    or	bootm <kernel_addr> <ramdisk_addr>
>
> NEW:	bootm <kernel_addr> - <dts_addr>
>    or	bootm <kernel_addr> <ramdisk_addr> <dts_addr>

do you mean a literal '-' char for the no ramdisk, but dts case?

- kumar
