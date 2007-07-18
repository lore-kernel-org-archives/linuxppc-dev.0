Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E03EDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 22:22:50 +1000 (EST)
Date: Wed, 18 Jul 2007 16:22:40 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 38/61] cpm2: Update device trees.
Message-ID: <20070718162240.557eea46@localhost.localdomain>
In-Reply-To: <20070718013549.GJ15238@ld0162-tx32.am.freescale.net>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013549.GJ15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jul 2007 20:35:50 -0500
Scott Wood wrote:

> +				             "fsl,cpm-uart";
>  				reg = <11a00 20 8000 100>;
> -				current-speed = <1c200>;
Hmm, how is it supposed to work without speed? I was testing my u-boot OF bindings for 82xx and spotted into it.


-- 
Sincerely, Vitaly
