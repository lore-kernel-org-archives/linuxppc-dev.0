Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 40250DE121
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Oct 2008 08:17:59 +1100 (EST)
Message-ID: <48EE74FF.9000809@freescale.com>
Date: Thu, 09 Oct 2008 16:17:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alemao <xcarandiru@gmail.com>
Subject: Re: MTD map drivers (FSL UPM NAND)
References: <d970ff420810091404j49492e80xcd9250d0ffdcd592@mail.gmail.com>
In-Reply-To: <d970ff420810091404j49492e80xcd9250d0ffdcd592@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alemao wrote:
> Hi all,
> 
> Im trying to use a physmap driver for NOR and NAND flash devices.

You can't use physmap with NAND.

>   ranges = <0 0 ff000000 1000000     // nor flash,  16 MB
>                     1 0 60000000 4000000>;   // nand flash, 64 MB

Is your NAND window really that large?  I'm not too familiar with UPM, 
but typically it'd only be a few KiB.

> So, how can I load the UPM driver before physmap?

Just stop pointing physmap at the NAND.

-Scott
