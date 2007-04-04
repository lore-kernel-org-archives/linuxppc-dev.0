Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A511DDF40
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 04:34:36 +1000 (EST)
Message-ID: <4613EFB3.4020104@freescale.com>
Date: Wed, 04 Apr 2007 13:34:27 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
	<4613E39A.70606@freescale.com> <4613E7CC.1020001@246tNt.com>
	<20070404181351.GA19855@ld0162-tx32.am.freescale.net>
	<4613EC2F.80109@freescale.com> <4613ED4F.2030203@freescale.com>
	<4613EE2C.3070104@freescale.com> <4613EF1F.6000704@freescale.com>
In-Reply-To: <4613EF1F.6000704@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

>> Otherwise, if you pass an unaligned value of 'start', then the buffer 
>> you get back will be less than 'size'.
> 
> That's better than the buffer you get back being bigger than the region 
> that's really free...

True, but I think both cases should be rejected.

> If I attach a region from 0x03 to 0x2d, and the alignment is 4, then the 
> only sane thing to do is allocate from 0x04 to 0x2b.

Or return an error.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
