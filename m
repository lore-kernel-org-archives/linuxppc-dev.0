Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0229767B6F
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 08:07:00 +1000 (EST)
Subject: Re: [PATCH] avoid NULL pointer in gpio1_interrupt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20060926202836.GA1051@aepfle.de>
References: <20060926202836.GA1051@aepfle.de>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 08:06:47 +1000
Message-Id: <1159308407.4435.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-26 at 22:28 +0200, Olaf Hering wrote:
> gpio1_interrupt() may dereference a NULL pointer if ioremap() fails.
> But, maybe no gpio interrupt happens in the first place?

Nah, they would happen. Good catch tho I fail to see how ioremap would
fail that early during boot :)

Ben.
