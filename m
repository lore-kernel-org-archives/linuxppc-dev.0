Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 702A5DDF99
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 04:08:15 +1100 (EST)
In-Reply-To: <20080402142417.5557.90153.stgit@pollux.denx.de>
References: <20080402142417.5557.90153.stgit@pollux.denx.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <12a34107cfdcecb57bc2619f6094e21f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RESEND3 PATCH] [POWERPC] mpc5200: Amalgamated DTS fixes and
	updates
Date: Wed, 2 Apr 2008 19:08:08 +0200
To: Bartlomiej Sieka <tur@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	lpb {
> +		model = "fsl,lpb";
> +		compatible = "fsl,lpb";

Please use a more descriptive name, if you can still change the binding.
"localplus" or something like that.

Maybe it's time to start an International Obfuscated Device Tree 
Contest,
to serve as a warning by example?

:-)


Segher
