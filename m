Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64D63DE51C
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:20:29 +1000 (EST)
Message-Id: <739A0024-FA8F-4CDC-8C34-B0230FEB7D0D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080415160231.GA2642@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [RESEND PATCH] cuboot-pq2: PCI fixes
Date: Tue, 15 Apr 2008 18:20:21 -0500
References: <20080415160231.GA2642@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 11:02 AM, Scott Wood wrote:
> 1. Detect (and bail out on) more conditions that violate the
> assumptions of the setup code -- we assume in such cases that the  
> device
> tree is correct and reflects what the firmware did.
>
> 2. The inbound memory mask calculation was wrong.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/boot/cuboot-pq2.c |   27 +++++++++++++++++++--------
> 1 files changed, 19 insertions(+), 8 deletions(-)

applied.

- k
