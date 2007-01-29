Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B68BDE02A
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 03:38:54 +1100 (EST)
In-Reply-To: <45BE2276.5010303@freescale.com>
References: <11691560171514-git-send-email-timur@freescale.com>	<309FC1DE-9724-4172-BB13-D301D4A783F8@kernel.crashing.org>	<45BA1952.80206@freescale.com>
	<EC5E5BA9-F865-40AC-8CA8-9B152AAC0908@kernel.crashing.org>
	<45BE2276.5010303@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2B16AB83-7726-4C84-B48E-254E8FEF734C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for the MPC8349E-mITX-GP
Date: Mon, 29 Jan 2007 10:37:52 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 29, 2007, at 10:36 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> I did this as well, I'm talking about the debug options being   
>> different and USB support.  (Not simple diffs handled by make   
>> menuconfig).
>
> I can't explain those.  I didn't touch the USB or debug options  
> when I changed the config for the ITX-GP.  I just changed the flash  
> configuration.  Now that I think about it, I should probably have  
> disabled SATA and a few other things that the ITX-GP is missing.
>
> What do you suggest I do?  Should I just try it again?

Well, I'd suggest trying it again based on the latest ITX defconfing  
and see what happens.  If you need to update both defconfigs to make  
them consistent I'm fine with that.  Just figured they should be  
insync (except the removed functionality for ITX-GP).

- k
