Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 625D4DDF93
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 05:28:33 +1000 (EST)
In-Reply-To: <1176402805.6379.84.camel@zod.rchland.ibm.com>
References: <1176402805.6379.84.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3d8deaa26ab67ccd0aeb4b827dc175a8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: Fix PowerPC 750CL and 750GX CPU features
Date: Thu, 12 Apr 2007 21:28:30 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> PowerPC 750CL has high BATs.  The patch below adds a CPU_FTRS_750CL 
> that
> includes that.  Without it, the original firmware mappings in the high 
> BATs
> aren't cleared which continue to override the linux translations.
>
> It also adds CPU_FTR_COMMON to CPU_FTRS_750GX for completeness.

Looks good to me, thanks Josh.  It would be nice to define
the 750XX features as plain 750 + a few options, but that's
a separate cleanup.


Segher
