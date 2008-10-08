Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A513DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Oct 2008 09:57:15 +1100 (EST)
Message-ID: <48ED3A31.60503@freescale.com>
Date: Wed, 08 Oct 2008 17:54:41 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Duy-Ky Nguyen <duykynguyen@hotmail.com>
Subject: Re: Failure in re-load module
References: <mailman.2847.1223488861.3127.linuxppc-embedded@ozlabs.org>
	<BLU119-DAV1197362B77CCC3F1296F60BB3B0@phx.gbl>
In-Reply-To: <BLU119-DAV1197362B77CCC3F1296F60BB3B0@phx.gbl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: v.selvamuthukumar@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Duy-Ky Nguyen wrote:
> release_region(ppc_base,PPC_SIZE);
> release_region(lbc_base,PPC_SIZE);

This should be PPC_BASE/LBC_BASE (the physical address), not 
ppc_base/lbc_base (the virtual address).

-Scott
