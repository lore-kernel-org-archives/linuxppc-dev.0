Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1770B67A5B
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 07:42:53 +1000 (EST)
In-Reply-To: <20060425213955.B9960352B18@atlas.denx.de>
References: <20060425213955.B9960352B18@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DAD4396E-7458-471C-8150-9DDCD396BA63@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim 
Date: Tue, 25 Apr 2006 16:42:47 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2006, at 4:39 PM, Wolfgang Denk wrote:

> In message <07A76292-03D1-4648- 
> AA40-11E06698FEE1@kernel.crashing.org> you wrote:
>>
>>> Since U-Boot  does  not  need  nor  use  this  information  for   
>>> it's
>>> operation, but the kernel does, it should be part of the kernel.
>>
>> What about the case in which u-boot already has a .dts for a given
>> board?  Should we duplicate the files between the kernel & u-boot?
>
> No. Remove them from the U-Boot tree. I was never happy to  see  this
> stuff there.

Then why did you accept the patches for them?  I'm confused on what  
you see as the solution for how to boot an arch/powerpc kernel going  
forward.

- k
