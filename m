Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2F4A0B7B6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 00:44:48 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6BDECDDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 00:44:47 +1000 (EST)
Message-Id: <A874E6FA-2F98-480E-AB73-66FD8695FE84@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090818232810.GA27907@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 1/3] powerpc/82xx: Fix BCSR bits for MPC8272ADS boards
Date: Tue, 25 Aug 2009 09:44:37 -0500
References: <20090818232810.GA27907@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 18, 2009, at 6:28 PM, Anton Vorontsov wrote:

> mpc8272_ads.c is using BCSR bits definitions from pq2ads.h, but
> according to User's Guide the bits are wrong for MPC8272ADS boards
> (I guess definitions from pq2ads should only be used for PQ2FADS
> boards).
>
> So, let's introduce our own definitions for MPC8272ADS, and don't
> include pq2ads.h.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/82xx/mpc8272_ads.c |    8 +++++++-
> 1 files changed, 7 insertions(+), 1 deletions(-)


applied to next.

- k
