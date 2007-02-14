Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23E00DDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:00:30 +1100 (EST)
Subject: Re: [PATCH] powerpc: add of_get_mac_address() and update fsl_soc.c
	to use it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1171408247467-git-send-email-timur@freescale.com>
References: <1171408247467-git-send-email-timur@freescale.com>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 11:00:19 +1100
Message-Id: <1171411219.20192.118.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +	return get_property(np, "address", NULL);

Since there is so much room for confusion with "address", please at
least do some basic sanity checking, like check that it's size is 6
bytes and maybe that the multicast bit isn't set.

Ben.
