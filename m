Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7933DDEAB
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:58:25 +1000 (EST)
In-Reply-To: <20071018180053.GA16748@localhost.localdomain>
References: <20071018180053.GA16748@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <875FF80D-D495-4285-8A9F-6A8DF176F4A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 1/2] [POWERPC] MPC8568E-MDS: create localbus node
Date: Thu, 18 Oct 2007 14:59:05 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 1:00 PM, Anton Vorontsov wrote:

> This patch creates localbus node, moves bcsr into it, and adds
> localbus to the probe path.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

why two patches for lbus and flash to lbus?

- k
