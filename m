Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C42BDDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Dec 2007 08:25:54 +1100 (EST)
Subject: Re: More patches added to for-2.6.25 and master branches of
	powerpc.git
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18282.19253.485799.233476@cargo.ozlabs.ibm.com>
References: <18282.19253.485799.233476@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 26 Dec 2007 08:25:31 +1100
Message-Id: <1198617931.7209.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>       [POWERPC] Disable PCI IO/Mem on a device when resources can't be allocated

Can you revert that one ? I messed up the flags (mixed up IORESOURCE_*
flags with command register bits).

I'll send a fixed up version when I'm back.

Cheers,
Ben.
