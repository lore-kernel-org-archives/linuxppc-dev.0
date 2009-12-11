Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20A5FB7C4B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 13:09:12 +1100 (EST)
Subject: Re: [PATCH 2/3] asm/gpio.h: support gpio_to_irq()
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1259700494-17869-2-git-send-email-jacmet@sunsite.dk>
Date: Thu, 10 Dec 2009 20:09:01 -0600
Message-Id: <DBFAB3B0-E713-467C-98B1-DC1E02155EC1@kernel.crashing.org>
References: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
	<1259700494-17869-2-git-send-email-jacmet@sunsite.dk>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 1, 2009, at 2:48 PM, Peter Korsgaard wrote:

> gpiolib returns -ENXIO if struct gpio_chip::to_irq isn't set, so it's
> safe to always call.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
> arch/powerpc/include/asm/gpio.h |    5 +----
> 1 files changed, 1 insertions(+), 4 deletions(-)

applied to next

- k
