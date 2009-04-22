Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EECD8DE31C
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:16:35 +1000 (EST)
Message-ID: <49EF5EFE.2040608@freescale.com>
Date: Wed, 22 Apr 2009 13:16:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/85xx: Add P2020DS board support
References: <1240371105-18400-1-git-send-email-galak@kernel.crashing.org>
	<20090422164400.GA9592@ld0162-tx32.am.freescale.net>
	<6EC8B59D-62C8-4D9B-B548-4833A06F13AB@kernel.crashing.org>
	<49EF4E27.9020203@freescale.com>
	<95BA4C47-8B99-4E94-9855-4333BB4A751C@kernel.crashing.org>
	<49EF50EC.1040608@freescale.com>
	<E25C4315-A3BA-42DF-B2D2-B1CD2D76A03F@kernel.crashing.org>
	<49EF560F.90208@freescale.com>
	<FA468435-A799-4EB9-8DA1-EC8F3B58EAEB@kernel.crashing.org>
In-Reply-To: <FA468435-A799-4EB9-8DA1-EC8F3B58EAEB@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> What "we care about" at this point is irrelevant, given the PITA it 
>> would be to change the device trees (or u-boot) that are already in 
>> use once we do begin to care.
> 
> Which is exactly why I didn't put it in the .dts right now.

???

> Today we know NO code exists that cares about "fsl,elbc-1.2". Once someone adds 
> such code they can also update the .dts to match it.

DTS files and firmware are *MUCH* harder to update once they're out 
there than the kernel.  Why such opposition to using an appropriate 
compatible?

Is there anything in the p2020ds u-boot patches to set the elbc version, 
or was that just a brush-off?

-Scott
