Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05687B7CCD
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 16:31:21 +1100 (EST)
Subject: Re: register long sp asm("r1") incorrect
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20100209152444.GA30176@atrey.karlin.mff.cuni.cz>
References: <20100209152444.GA30176@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 11 Feb 2010 16:31:13 +1100
Message-ID: <1265866273.16346.34.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-02-09 at 16:24 +0100, Pavel Machek wrote:
> ...according to gcc docs, sp should be global, or placement in
> register is not guaranteed (except at asm boundaries, but there are
> none).

Sorry I'm not sure I grok what you mean.

Cheers,
Ben.
