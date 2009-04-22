Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 959C7DE055
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:25:39 +1000 (EST)
Message-Id: <38B5E2ED-1603-486E-87DB-2F68DFD31DEC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <49EF5EFE.2040608@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v3] powerpc/85xx: Add P2020DS board support
Date: Wed, 22 Apr 2009 13:23:32 -0500
References: <1240371105-18400-1-git-send-email-galak@kernel.crashing.org>
	<20090422164400.GA9592@ld0162-tx32.am.freescale.net>
	<6EC8B59D-62C8-4D9B-B548-4833A06F13AB@kernel.crashing.org>
	<49EF4E27.9020203@freescale.com>
	<95BA4C47-8B99-4E94-9855-4333BB4A751C@kernel.crashing.org>
	<49EF50EC.1040608@freescale.com>
	<E25C4315-A3BA-42DF-B2D2-B1CD2D76A03F@kernel.crashing.org>
	<49EF560F.90208@freescale.com>
	<FA468435-A799-4EB9-8DA1-EC8F3B58EAEB@kernel.crashing.org>
	<49EF5EFE.2040608@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 22, 2009, at 1:16 PM, Scott Wood wrote:

> Kumar Gala wrote:
>>> What "we care about" at this point is irrelevant, given the PITA  
>>> it would be to change the device trees (or u-boot) that are  
>>> already in use once we do begin to care.
>> Which is exactly why I didn't put it in the .dts right now.
>
> ???
>
>> Today we know NO code exists that cares about "fsl,elbc-1.2". Once  
>> someone adds such code they can also update the .dts to match it.
>
> DTS files and firmware are *MUCH* harder to update once they're out  
> there than the kernel.  Why such opposition to using an appropriate  
> compatible?

Because I want to avoid make the decision right now.  We are on rev1.x  
silicon and I want to avoid greatly having to spawn a new .dts just  
for "fsl,elbc-1.2.1" that has some errata fix in it.  If dtc was  
smarter and I had less duplication between the 40-50 .dts we have for  
our various parts I wouldn't care that match.

> Is there anything in the p2020ds u-boot patches to set the elbc  
> version, or was that just a brush-off?

I was hoping that Poonam would look at doing that, but there isn't  
anything right now.

I can put out some code for u-boot to address the specific elbc issue  
if that will resolve this.

- k
