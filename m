Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CAEADDEF1
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 08:34:48 +1000 (EST)
Message-ID: <469D43DD.8020102@freescale.com>
Date: Tue, 17 Jul 2007 17:34:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Add StorCenter DTS first draft.
References: <E1IAnwC-0003Xm-6U@jdl.com>	<630B6BC9-389F-4F5C-AE8F-9C3131C4543E@kernel.crashing.org>
	<E1IAvVm-0005yQ-LO@jdl.com>
In-Reply-To: <E1IAvVm-0005yQ-LO@jdl.com>
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

Jon Loeliger wrote:
> How about "soc8241@80000000" instead?
> 
> That would be similar to:
>         soc8641@f8000000 {
> and
>        soc8272@f0000000 {

How about just "soc@80000000"?  Those model numbers in the names are a 
PITA to find from limited functionality environments such as the 
bootwrapper, require things like stdout-path to be different on every 
soc, and don't comply with the generic names recommendation.

-Scott
