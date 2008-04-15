Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20BB7DE1AF
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:25:12 +1000 (EST)
Message-Id: <80CCBF8C-FE21-4DD7-B1CF-0647D31655D9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <20080415224628.GA21663@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
Date: Tue, 15 Apr 2008 18:24:58 -0500
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
	<4804D39C.9000309@freescale.com> <4804D7C4.8060805@windriver.com>
	<4804D867.4070205@freescale.com>
	<20080415224628.GA21663@windriver.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 5:46 PM, Paul Gortmaker wrote:
> In message: Re: [PATCH] 86xx: mark functions static, other minor  
> cleanups
> on 15/04/2008 Timur Tabi wrote:
>
>> Paul Gortmaker wrote:
>>
>>> Valid point.  Is there a precedent here -- like a printk indicating
>>> that the old ID matched, to let the user know?
>>
>> Not really, but a pr_warning() would be nice.
>
> Done.
>
> I've also removed the sbc8641 content from this patch, and rolled it
> into the resend of those board specific patches.  This is now just for
> incorporating that same feedback into existing boards.
>
> Thanks,
> Paul.
> ---
>
> From aa2d1dd871c7eb440b3947cf8952d28249acf218 Mon Sep 17 00:00:00 2001
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Fri, 11 Apr 2008 12:51:04 -0400
> Subject: [PATCH] 86xx: mark functions static, other minor cleanups
>
> Cleanups as suggested by Stephen Rothwell and Dale Farnsworth, which
> incudes marking a bunch of functions static and add a vendor prefix to
> the compat node check for uniqueness.  We match on the old compat node
> ID for one version and warn accordingly, so as to not plunge people
> into silent boot death, as suggested by Timur Tabi.

can you add a commit about the change to the root compatible and its  
eventual removal for backward compatibility.

- k
