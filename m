Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB382DF0E3
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 05:11:53 +1000 (EST)
In-Reply-To: <20080411184312.GA23941@windriver.com>
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
	<20080411171628.GA3203@loki.buserror.net>
	<20080411184312.GA23941@windriver.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <28ac27892f91a47cd620aee7b7b9ecdb@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
Date: Fri, 11 Apr 2008 21:11:30 +0200
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Updated as per above, and with tickerized prefixes for sbc8641.

Care to try once more?  It's only "tickerized" if it's in all
uppercase.

> +	compatible = "wind,sbc8641";


Segher
