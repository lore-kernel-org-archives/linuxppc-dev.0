Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 070E767C5D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 00:48:29 +1000 (EST)
Subject: Re: [PATCH 4/4] powerpc: Cell timebase workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061012091455.6409046e@localhost.localdomain>
References: <1160641804.4792.136.camel@localhost.localdomain>
	<20061012091455.6409046e@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 00:48:21 +1000
Message-Id: <1160664501.4792.149.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The above is a bit obfuscated. Please make the MFTB() macro use the
> nested version of the feature definitions, and let the surrounding code
> use the base one. Otherwise it will be really easy to mix them up by
> mistake, there's no exposure at the time of MFTB() usage that it uses
> feature labels.

Yup, I was thinking about doing that at one point and it slipped out of
my mind. Thanks for reminding me :)

Cheers,
Ben.
