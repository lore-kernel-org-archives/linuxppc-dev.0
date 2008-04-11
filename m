Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 53FBDDE672
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 05:22:21 +1000 (EST)
Message-ID: <47FFBABA.9040309@scram.de>
Date: Fri, 11 Apr 2008 21:23:38 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH3/7] i2c: OF helpers for the i2c API
References: <47FF710D.2040208@scram.de>
	<20080411.104306.93639801.davem@davemloft.net>
In-Reply-To: <20080411.104306.93639801.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	scottwood@freescale.com, i2c@lm-sensors.org, khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller schrieb:

> I wouldn't mind trying to use this infrastructure on
> sparc64, and I don't see any powerpc specific interfaces
> being invoked, so if you could remove the PPC_OF
> requirement I'd appreciate it.

I've resenf the patch without the dependency on PPC_OF.

Thanks for the comment.
Jochen
