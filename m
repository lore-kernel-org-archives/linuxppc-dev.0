Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC9BFDDD08
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 06:42:34 +1000 (EST)
Message-ID: <46B0F030.9030007@freescale.com>
Date: Wed, 01 Aug 2007 15:42:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>	<87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>	<Pine.LNX.4.60.0707191932300.3365@poirot.grange>	<719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>	<Pine.LNX.4.60.0707202219340.3946@poirot.grange>	<235e0ff22961e25016727c0e74fd0c0f@kernel.crashing.org>	<Pine.LNX.4.60.0708010739560.4228@poirot.grange>	<19a13f8700d078abc4cab0064a7d0183@kernel.crashing.org>
	<Pine.LNX.4.60.0708012053240.7394@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0708012053240.7394@poirot.grange>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
> And the only safe way is 
> 
> 	strncpy(z.c, c, 3);
> 	z.c[3] = '\0';
> 
> with compilers < 4.2?...

You could use strlcpy() instead, which always leaves a zero terminator.

-Scott
