Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25800DF4A5
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 02:52:54 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7MGql6w011072
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 09:52:48 -0700 (MST)
Message-Id: <FF90B0AE-E6DF-4848-AA82-1450F9539C01@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <0718A6AE-8C34-4E36-9365-A893285D3D01@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] POWERPC: Change total_memory to phys_addr_t
Date: Fri, 22 Aug 2008 11:52:41 -0500
References: <1219349438-21436-1-git-send-email-becky.bruce@freescale.com>
	<0718A6AE-8C34-4E36-9365-A893285D3D01@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It turns out that the commit message was out of date, and the patch  
itself was correct.  I have resubmitted with a different title/log, so  
this patch can be ignored.

Cheers,
B

On Aug 22, 2008, at 10:26 AM, Becky Bruce wrote:

> Gah, I just noticed that part of this patch is missing - I will  
> resubmit as soon as I figure out what the heck happened.
>
> -Becky
>
