Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C26A67B92
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 11:03:46 +1000 (EST)
Subject: Re: [PATCH] [v3] PPC 4xx: Enable XMON on PPC 4xx boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jdub@us.ibm.com>
In-Reply-To: <1157652525.6098.61.camel@zod.rchland.ibm.com>
References: <1157639720.6098.49.camel@zod.rchland.ibm.com>
	<20060907171916.GB18929@gate.ebshome.net>
	<1157652525.6098.61.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 11:03:23 +1000
Message-Id: <1157677403.22705.360.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: mporter@embeddedalley.com, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Blindly following the existing convention.  I agree it's ugly.  I'll fix
> it up shortly and send out another patch.  It'll also fix 440SPE, which
> also has a different UART address.

It should all move to udbg anyway

Ben.
