Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E9A6B6F89
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 08:03:56 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p51Lgf8b001904
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2011 17:42:41 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p51M3rB4123406
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2011 18:03:53 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p51M3rdM028150
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2011 19:03:53 -0300
Received: from manic8ball.ltc.austin.ibm.com ([9.12.225.18])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p51M3qD2028127
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2011 19:03:52 -0300
Message-ID: <4DE6B748.3010109@linux.vnet.ibm.com>
Date: Wed, 01 Jun 2011 17:03:52 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] document udbg-immortal
References: <alpine.DEB.2.01.1105311817240.21697@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.01.1105311817240.21697@trent.utfs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2011 08:22 PM, Christian Kujau wrote:

> +	udbg-immortal	[PPC] When debugging early kernel crashes that
> +			happen after console_init() and before a proper 
> +			console driver takes over, this boot options might
> +			help "seeing" what's going on.
> +

Thanks for documenting this!

Suggested grammatical tweaks:

s/options/option/
s/help "seeing"/help to "see"/

-- 

Jesse Larrew
Software Engineer, Linux on Power Kernel Team
IBM Linux Technology Center
Phone: (512) 973-2052 (T/L: 363-2052)
jlarrew@linux.vnet.ibm.com
