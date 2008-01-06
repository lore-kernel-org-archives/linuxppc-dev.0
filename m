Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C749DDE23
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 07:50:05 +1100 (EST)
Subject: Re: [PATCH] Fix remainder calculating bug in single floating point
	division
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <66F0B96A-5B53-48D3-BB90-07841F3EA1EE@embeddedalley.com>
References: <11996296134110-git-send-email-Yu.Liu@freescale.com>
	<1199650065.7291.81.camel@pasglop>
	<66F0B96A-5B53-48D3-BB90-07841F3EA1EE@embeddedalley.com>
Content-Type: text/plain
Date: Mon, 07 Jan 2008 07:49:33 +1100
Message-Id: <1199652574.7291.85.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Liu Yu <Yu.Liu@freescale.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-01-06 at 12:44 -0800, Dan Malek wrote:
> While it's convenient, I still don't think kernel float
> emulation should be a solution.  The tools should
> generate soft-float for the applications and libraries.

I agree, for deployement, it's definitely not a solution, though it's
very convenient for us hackers :-)

Ben.
