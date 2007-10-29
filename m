Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BB98DE107
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 10:17:25 +1100 (EST)
Subject: Re: [PATCH] [powerpc] update xmon slb code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071029205254.GA27544@lixom.net>
References: <20071029195925.9773.94394.stgit@farscape.rchland.ibm.com>
	<20071029205254.GA27544@lixom.net>
Content-Type: text/plain
Date: Tue, 30 Oct 2007 10:17:15 +1100
Message-Id: <1193699835.9928.45.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Nice, I like it! I wonder if it would make sense to (space) pad the
> ESID/VSID fields so they line up, it'd make output just a little tidier.
> 
> (If you end up changing that, please also break the long printf lines
> in two.)
> 
> Beside that it looks good to me! :)

Can you also print out the LLP bits ? (I won't ask you to also decode
the page size though that would be useful :-)

Cheers,
Ben.
