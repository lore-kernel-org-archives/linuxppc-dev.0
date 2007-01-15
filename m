Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D717DDED9
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 02:53:53 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816B9F@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816B9F@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <61343545c961e9ea0bba949dd8a66802@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Mon, 15 Jan 2007 16:54:30 +0100
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Thanks for your reminder, I would like to correct what I said before.
> FP round interrupt may be taken on some circumstance that FP
> data interrupt doesn't take place, so we may still have to handle round
> interrupt to fully comply IEEE-754. Do you think using the same way to
> handle FP round interrupt as FP data interrupt is a reasonable 
> approach?

Well you would take and handle the exception with similar
code, based on the same config option too.  The actual way
to handle the math is very different I suppose, like Kumar
said.


Segher
