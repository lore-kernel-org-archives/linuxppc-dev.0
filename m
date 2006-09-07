Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0562667B7B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 20:59:17 +1000 (EST)
Message-ID: <44FFFB70.2080903@cambridgebroadband.com>
Date: Thu, 07 Sep 2006 11:58:56 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: Re: MPC8360E USB Host Controller Driver
References: <4879B0C6C249214CBE7AB04453F84E4D14C78C@zch01exm20.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D14C78C@zch01exm20.fsl.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: n.balaji@gdatech.co.in, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> manual, they told that this controller does not belong to 
>> UHCI or OHCI standard.
> 
> Yes, you can call it FHCI if you like. :)

I heard that on the PQII (82xx) devices the FHCI required
intervention from the core, even when there was zero traffic
on the USB.  I think this was because the core had to
continuously service a 1ms interrupt.  This generates significant
extra loading, making it worth considering using a cheap EHCI chip
instead....

Does anyone know if this is still the case with the PQII Pro (83xx)?

Alex
