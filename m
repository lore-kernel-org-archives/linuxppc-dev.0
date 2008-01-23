Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E0C0DDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 03:12:42 +1100 (EST)
Message-Id: <8390AE9D-AB54-4D7A-840E-0D08637B50FE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <47976499.9050505@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCHv2 4/8] [POWERPC] Remove declaration of m8xx_pic_init.
Date: Wed, 23 Jan 2008 10:07:30 -0600
References: <47976499.9050505@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 23, 2008, at 10:00 AM, Jochen Friedrich wrote:

> m8xx_pic_init is declared in ppc8xx_pic.h but defined nowhere in the  
> ppc
> tree. Remove it.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>

if we respin the patches, merge this with 2/8 - Rename m8xx_pic_init  
to mpc8xx_pics_init.

(otherwise i'll merge when I commit).

- k
