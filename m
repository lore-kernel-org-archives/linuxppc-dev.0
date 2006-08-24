Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EE2A67CA5
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 21:13:48 +1000 (EST)
Subject: Re: [PATCH ] powerpc: Add tsi108/9 and non standard mpic support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1156417448.7107.1.camel@localhost.localdomain>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19E353@zch01exm23.fsl.freescale.net>
	<1156398135.5913.43.camel@localhost.localdomain>
	<1156398861.8433.197.camel@localhost.localdomain>
	<1156413135.6591.14.camel@localhost.localdomain>
	<1156416857.8433.244.camel@localhost.localdomain>
	<1156417448.7107.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 21:13:23 +1000
Message-Id: <1156418003.8433.246.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I have tested on mpc8641hpcn board with CONFIG_MPIC.

I need to test it with normal MPIC machines and CONFIG_MPIC_WEIRD
enabled

> Hope to see it in 2.6.18.

This is not my call unfortunately though I reckon that it could go in
since it's been sitting around for a while. We'll see.

Ben.
