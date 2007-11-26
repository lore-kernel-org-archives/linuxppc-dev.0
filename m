Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11298DDE11
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 21:28:27 +1100 (EST)
Date: Mon, 26 Nov 2007 13:28:07 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH revised 3/4] powerpc: Add EXPORT_SYMBOL_GPL for symbols
	required by fs_enet and cpm_uart
Message-ID: <20071126132807.5f788f7a@kernel.crashing.org>
In-Reply-To: <19DACFA1-05DB-4331-BE71-282590B9DFE5@embeddedalley.com>
References: <4745BDC9.3080602@scram.de> <47499711.2020409@freescale.com>
	<20071125191833.1e76f335@kernel.crashing.org>
	<19DACFA1-05DB-4331-BE71-282590B9DFE5@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 25 Nov 2007 13:02:03 -0800
Dan Malek wrote:

> 
> On Nov 25, 2007, at 8:18 AM, Vitaly Bordug wrote:
> 
> > To prevent using those pointers from within non-GPL modules. kind  
> > of policy now...
> 
> As the original copyright holder of nearly all of this of
> this code, I do not wish this be done.

In this particular case this is not going to happen anyway, but I will take your opinion into
account for the similar cases.


-- 
Sincerely, Vitaly
