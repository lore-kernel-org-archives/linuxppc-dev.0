Return-Path: <timur@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 32F49B7BB8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 08:33:10 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA5DBDDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 08:33:08 +1000 (EST)
Message-ID: <4A8B2C1C.3060403@freescale.com>
Date: Tue, 18 Aug 2009 17:33:00 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2] qe_lib: Set gpio data before changing the direction
	to output
References: <4A8B164E.6030704@ruggedcom.com>
	<20090818210805.GA1725@oksana.dev.rtsoft.ru>
	<4A8B1B2C.5090606@ruggedcom.com>
	<20090818213355.GA20966@oksana.dev.rtsoft.ru>
In-Reply-To: <20090818213355.GA20966@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Michael Barkowski <michaelbarkowski@ruggedcom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Tue, Aug 18, 2009 at 05:20:44PM -0400, Michael Barkowski wrote:
>> This avoids having a short glitch if the desired initial value is not
>> the same as what was previously in the data register.
>>
>> Signed-off-by: Michael Barkowski <michaelbarkowski@ruggedcom.com>
> 
> Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

I don't have the time to test this patch, so I abstain from acking. :-)  If Anton likes it, that's good enough for me.

-- 
Timur Tabi
Linux kernel developer at Freescale
