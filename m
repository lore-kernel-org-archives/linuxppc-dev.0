Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9526468A61
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jan 2006 03:56:20 +1100 (EST)
Message-ID: <43CBD02B.1070408@ovro.caltech.edu>
Date: Mon, 16 Jan 2006 08:56:11 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: PPC440EP/Yosemite PCI misbehavior
References: <43C7292B.2060003@ovro.caltech.edu>
	<43C88013.40800@ovro.caltech.edu> <200601151021.13798.sr@denx.de>
In-Reply-To: <200601151021.13798.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Stefan,

> I have to admit, that PCI I/O can't have worked until now on 
> Yosemite/Yellowstone. I just found a bug in 
> arch/ppc/platforms/4xx/yosemite.h:
> 
> -#define YOSEMITE_PCI_IO_BASE		0x00000000e0000000ULL
> +#define YOSEMITE_PCI_IO_BASE		0x00000000e8000000ULL
> 
> Please give it a try and let me know if the problem is fixed.

Yes, that was it! Its all working now.

Thanks very much!
Dave
