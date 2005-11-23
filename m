Return-Path: <SRS0+b54f8ebc752649c30a08+822+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B62E687EA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 03:15:55 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: hs@denx.de
In-Reply-To: <AHEILKONAKAEJPHNMOPNMEMKCDAA.hs@denx.de>
References: <AHEILKONAKAEJPHNMOPNMEMKCDAA.hs@denx.de>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Nov 2005 16:15:29 +0000
Message-Id: <1132762529.15117.281.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
Subject: RE: [PATCH]	MTD:	Add support for the PM82x Boards.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-11-23 at 17:08 +0100, Heiko Schocher wrote:
> I ported this code from the 2.4er Kernel, so I didn´t know
> the background, why this code uses the jedec-probe. What
> exactly bothers you?

The JEDEC tables are large enough already -- if the chips do support the
CFI probe, then I'd prefer not to add them to the table.

-- 
dwmw2
