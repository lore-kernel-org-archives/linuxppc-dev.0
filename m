Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id 47F6367A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 00:15:50 +1000 (EST)
Message-ID: <42B181F3.2090901@varma-el.com>
Date: Thu, 16 Jun 2005 17:43:15 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
References: <Pine.OSF.4.05.10506160040020.28990-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10506160040020.28990-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200/Lite5200 and ethernet
Reply-To: avolkov@varma-el.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Esben

Esben Nielsen wrote:
> How do I turn on the in chip FEC ethernet controller in MPC5200 in the
> stock 2.6.12-rc6 kernel? Do I need an extra patch?
> 
take patch here:
http://ozlabs.org/pipermail/linuxppc-embedded/2005-April/017591.html

But, since bestcomm still not converted to platform_bus/ppc_sys model,
it will not be included in vanilla 2.6.12 kernel.

-- 
Regards
Andrey Volkov
