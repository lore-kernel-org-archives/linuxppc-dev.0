Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CE13DB83AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 00:45:08 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 201ABDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 00:45:07 +1000 (EST)
Message-Id: <E7699B6B-884A-4A11-8D3D-BA3BFDE05F60@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Barkowski <michaelbarkowski@ruggedcom.com>
In-Reply-To: <4A8B1B2C.5090606@ruggedcom.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH v2] qe_lib: Set gpio data before changing the direction to
	output
Date: Tue, 25 Aug 2009 09:44:59 -0500
References: <4A8B164E.6030704@ruggedcom.com>
	<20090818210805.GA1725@oksana.dev.rtsoft.ru>
	<4A8B1B2C.5090606@ruggedcom.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 18, 2009, at 4:20 PM, Michael Barkowski wrote:

> This avoids having a short glitch if the desired initial value is not
> the same as what was previously in the data register.
>
> Signed-off-by: Michael Barkowski <michaelbarkowski@ruggedcom.com>
> ---
> Anton Vorontsov wrote:
>> There is a recursive locking bug: _set() takes the same spinlock.
>> So you'd better move this call two lines upper. Otherwise the
>> patch looks OK.
>>
>> Thanks!
>
> Thanks - here is v2.
>
> arch/powerpc/sysdev/qe_lib/gpio.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)


applied to next.

- k
