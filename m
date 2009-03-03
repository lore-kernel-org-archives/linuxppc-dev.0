Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0182DDDEF1
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 13:16:31 +1100 (EST)
Message-ID: <49AC92E0.3060106@freescale.com>
Date: Mon, 02 Mar 2009 20:16:00 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: add defintion for MSR[GS] to list of MSR bits
References: <1236018001-3206-1-git-send-email-timur@freescale.com>
	<3431.1236042121@neuling.org>
In-Reply-To: <3431.1236042121@neuling.org>
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

Michael Neuling wrote:

>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>
> Shouldn't this be in reg_booke.h?

Yes, you're right.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
