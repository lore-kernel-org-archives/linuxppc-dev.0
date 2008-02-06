Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCFB9DDE04
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 16:44:08 +1100 (EST)
Message-Id: <D868D2E9-27BB-48BD-9E27-D1F6D0B60701@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <12021712873501-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v2] Add oprofile support for e300
Date: Tue, 5 Feb 2008 23:43:44 -0600
References: <12021712873501-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 4, 2008, at 6:28 PM, Andy Fleming wrote:

> The e300 c3 and c4 variants support hardware performance monitor  
> counters which
> are identical to those found in the e500.
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/kernel/cputable.c |    6 ++++++
> arch/powerpc/platforms/Kconfig |    1 +
> 2 files changed, 7 insertions(+), 0 deletions(-)

applied.

- k
