Return-Path: <David.Daney@caviumnetworks.com>
Received: from mail3.caviumnetworks.com (mail3.caviumnetworks.com
	[12.108.191.235]) by ozlabs.org (Postfix) with ESMTP id 40A171007F0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 09:22:40 +1000 (EST)
Message-ID: <4C2A7E14.4060802@caviumnetworks.com>
Date: Tue, 29 Jun 2010 16:13:24 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/9] Add Synopsys DesignWare HS USB OTG Controller driver.
References: <5569.83301.qm@web180304.mail.gq1.yahoo.com>
In-Reply-To: <5569.83301.qm@web180304.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2010 03:41 PM, David Brownell wrote:
> Good -- MUSB won't be the only one.  ;)
>
> Could you mention a few Linux-enabled chips which
> include this controller?
>

I can.  Some members of the Octeon family:  arch/mips/cavium-octeon

Although there would probably be some SOC specific glue needed for chips 
not targeted by the initial patch set.

David Daney


>
>>   arch/powerpc/boot/dts/kilauea.dts |   15 +
>
> Also, please provide a clean patch that only
> includes the driver, and split PPC hooks into
> a separate patch.
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
