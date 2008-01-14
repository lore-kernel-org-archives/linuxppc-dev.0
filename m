Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id F363EDDE32
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 04:32:39 +1100 (EST)
Message-ID: <478B9CB6.7000408@pikatech.com>
Date: Mon, 14 Jan 2008 12:32:38 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] MTD for Taco
References: <477F12D1.2070109@pikatech.com>	<200801051041.18173.sr@denx.de>	<478AEB39.70106@pikatech.com>
	<20080114024432.1dcba2f7@vader.jdub.homelinux.org>
In-Reply-To: <20080114024432.1dcba2f7@vader.jdub.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
>
> But did you go back and verify the EBC settings were correct on your
> board?  This shouldn't be needed at all if the EBC bank settings and
> timings are correct.
>
> josh
>   

In the EBC0_CFG register we set the RTC (Ready Timeout Count) to 0 and 
the sequoia uses 7. Also we set the EMS (External Master Size) to none 
and the sequoia sets it to 8 bit.

This is in uboot, the dts are basically the same.

Cheers,
    Sean
