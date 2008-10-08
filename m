Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 734E1DE4CB
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 05:57:40 +1100 (EST)
Message-Id: <0DDA754F-352B-45E7-9BA9-7DF0F2BB6A5E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48ED012A.6080403@genesi-usa.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 0/3] MPC5121 add pci support
Date: Wed, 8 Oct 2008 13:56:17 -0500
References: <1223406020-12278-1-git-send-email-jrigby@freescale.com>	
	<48ECD1DD.8030004@genesi-usa.com>
	<fa686aa40810080831l6348c1d8w8b2d197f07da8e2c@mail.gmail.com>
	<48ED012A.6080403@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2008, at 1:51 PM, Matt Sealey wrote:

>
> Grant Likely wrote:
>> On Wed, Oct 8, 2008 at 9:29 AM, Matt Sealey <matt@genesi-usa.com>  
>> wrote:
>>> If this patchset is okay with everyone, is it possible that it could
>>> be rushed into 2.6.27 before it hits rc10 or release? :/
>> no
>
> Shucks :(
>
> At least it'll patch cleanly against 2.6.27 though right? It doesn't  
> look
> very intrusive..

It should patch cleanly against 2.6.27.. A few simple git cherry-picks  
will get you what you want.

- k
