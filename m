Return-Path: <timur@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7381DB70D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 06:00:56 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06D1ADDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 06:00:55 +1000 (EST)
Message-ID: <4A96E5E9.1030607@freescale.com>
Date: Thu, 27 Aug 2009 15:00:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/5] powerpc/qe: Increase MAX_QE_RISC to 4
References: <20090827173011.GA739@oksana.dev.rtsoft.ru>
In-Reply-To: <20090827173011.GA739@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> MPC8569 CPUs have four QE RISCs, so we need to increase MAX_QE_RISC
> constant, otherwise qe_upload_firmware() fails at sanity checking.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>

Anton, I'll review the rest of your patches next week.  I'm too busy to do it now.

-- 
Timur Tabi
Linux kernel developer at Freescale
