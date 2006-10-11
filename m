Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16CFB67B7C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 08:16:24 +1000 (EST)
Subject: Re: Graphic issues (emulating VGA bios on IBM Maple)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jean-francois simon <jfaslist@yahoo.fr>
In-Reply-To: <20061010203620.771.qmail@web27502.mail.ukl.yahoo.com>
References: <20061010203620.771.qmail@web27502.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 08:16:18 +1000
Message-Id: <1160604978.4792.12.camel@localhost.localdomain>
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


> [C000000000BFFE60] [C0000000003CCC9C] .radeonfb_old_init+0x164/0x188

Try getting rid of the old radeonfb and see if that works.

Ben.
