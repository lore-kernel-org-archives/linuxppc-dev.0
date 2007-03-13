Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE27FDDE46
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 10:16:15 +1100 (EST)
In-Reply-To: <20070313181617.GA5360@ld0162-tx32.am.freescale.net>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<4CB3B3D5-6D4A-4D67-92FC-3B8C38850326@kernel.crashing.org>
	<20070313181617.GA5360@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F7652F68-D6FF-465C-BC8F-4F0C4D976AC0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Date: Tue, 13 Mar 2007 13:50:41 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 13, 2007, at 1:16 PM, Scott Wood wrote:

> On Mon, Mar 12, 2007 at 04:07:57PM -0500, Kumar Gala wrote:
>> On Mar 12, 2007, at 3:42 PM, Scott Wood wrote:
>>> The device trees currently in the kernel tree must have
>>> /chosen/linux,stdout-path added to work with cuboot.
>>
>> Why is linux,stdout-path needed by cuboot?
>
> It's used by serial.c to find the console, and the kernel requires  
> it as
> well.  There's no information in the bd_t that would allow the
> bootwrapper to generate this, so it has to come from the device tree.
>
> The only reason it's not required with dt-enabled u-boot is that u- 
> boot
> has it hardcoded in the board's config file.

I don't think we should put this into the .dts but, have code in the  
wrapper that handles it.

- k
