Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EA70DE041
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 06:56:29 +1100 (EST)
In-Reply-To: <45BE4BC0.5050402@freescale.com>
References: <11691560171514-git-send-email-timur@freescale.com>	<309FC1DE-9724-4172-BB13-D301D4A783F8@kernel.crashing.org>	<45BA1952.80206@freescale.com>	<EC5E5BA9-F865-40AC-8CA8-9B152AAC0908@kernel.crashing.org>	<45BE2276.5010303@freescale.com>
	<2B16AB83-7726-4C84-B48E-254E8FEF734C@kernel.crashing.org>
	<45BE4BC0.5050402@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5899C4E3-6AFE-4B04-AF4E-BF0AA382AA71@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for the MPC8349E-mITX-GP
Date: Mon, 29 Jan 2007 13:55:26 -0600
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


On Jan 29, 2007, at 1:32 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> Well, I'd suggest trying it again based on the latest ITX  
>> defconfing  and see what happens.  If you need to update both  
>> defconfigs to make  them consistent I'm fine with that.  Just  
>> figured they should be  insync (except the removed functionality  
>> for ITX-GP).
>
> Ok, I'll make new patch that updates the ITX config file and makes  
> an ITX-GP config file and keeps the diffs to a minimum.  I'll  
> submit it when the window for 2.6.21 opens.

Please don't wait for the window.  I've already got a branch for 83xx  
2.6.21 patches going.

- k
