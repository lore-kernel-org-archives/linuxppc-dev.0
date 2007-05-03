Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 094F2DDFAB
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 02:20:23 +1000 (EST)
In-Reply-To: <1178209046.17201.55.camel@ld0161-tx32>
References: <1178142818.32136.51.camel@ld0161-tx32>
	<08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>
	<1178207725.17201.33.camel@ld0161-tx32>
	<20070503161000.GA31881@lixom.net>
	<1178209046.17201.55.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3C4D879A-E756-45EA-AB67-70902797ED35@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
Date: Thu, 3 May 2007 11:19:21 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: Olof Johansson <olof@lixom.net>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 3, 2007, at 11:17 AM, Jon Loeliger wrote:

> On Thu, 2007-05-03 at 11:10, Olof Johansson wrote:
>
>>
>> This sounds like something that firmware should take care of, not
>> hardcoded in the board code.  Seems like the device is just a PCI  
>> device
>> that doesn't have a device tree entry.
>
> Well, it's not a PCI device at all.
>
>> Why not do this in u-boot instead?
>
> Why do it there?  We'd have to do it _again_ in Linux
> if we didn't come in from U-Boot anyway.

I agree with Jon here.  This is in board specific code so I don't see  
any issue with it.

- k
