Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E4C3DE06D
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:42:35 +1000 (EST)
Message-ID: <469E42F0.1080902@freescale.com>
Date: Wed, 18 Jul 2007 11:42:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 38/61] cpm2: Update device trees.
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>	<20070718013549.GJ15238@ld0162-tx32.am.freescale.net>
	<20070718162240.557eea46@localhost.localdomain>
In-Reply-To: <20070718162240.557eea46@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> On Tue, 17 Jul 2007 20:35:50 -0500
> Scott Wood wrote:
> 
> 
>>+				             "fsl,cpm-uart";
>> 				reg = <11a00 20 8000 100>;
>>-				current-speed = <1c200>;
> 
> Hmm, how is it supposed to work without speed? I was testing my u-boot OF bindings for 82xx and spotted into it.

The same way all the other device trees without current-speed work -- 
one passes console=whatever on the command line.

Feel free to have u-boot add the actual current speed (rather than a 
hardcoded default speed) if you want, though.

-Scott
