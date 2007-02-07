Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF5FBDDE02
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 09:15:53 +1100 (EST)
In-Reply-To: <45CA4DBC.7090401@freescale.com>
References: <45CA41F7.6020700@freescale.com>
	<1170883956.2620.305.camel@localhost.localdomain>
	<45CA47AB.1000302@freescale.com>
	<0EF1DDFB-E590-422C-8FA6-0FD643E68F49@kernel.crashing.org>
	<45CA4DBC.7090401@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <31D17474-FA61-4E0A-9114-FB6C965451FF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mac-address vs. local-mac-address
Date: Wed, 7 Feb 2007 16:14:58 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2007, at 4:07 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> The problem with u-boot is that the correct way would be to use  
>> local-mac-address for what's compiled into u-boot and mac-address  
>> if someone does a 'setenv' to modify the mac address.  The  
>> question is anyone really going to care that much.
>
> I don't think the compiled-in MAC address should be used at all.
>
> For most boards, the compiled-in option is just some random MAC  
> address.  When the board is shipped, the manufacturer creates his  
> own set of environment variables and overrides what's stored on flash.

And where does the mfg store these?

> I actually think that storing a MAC address in a board  
> configuration for or a DTS is a bad idea, because MAC addresses are  
> supposed to be unique for each Ethernet device, and storing a fixed  
> value in a source file breaks that. However, that's a separate  
> issue.  I was just trying to stress that the compiled-in MAC  
> address is of no value.

Ok, so 'compiled-in' wasn't the best choice.  What I meant is 'local- 
mac-address' is the MAC address u-boot decides to use when it boots  
before any user interaction.  (this may be the compiled-in one, or  
one from flash env settings, or whatever other source the board code  
decides).

- k
