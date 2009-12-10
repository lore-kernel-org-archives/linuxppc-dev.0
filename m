Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F88AB6F01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 01:53:23 +1100 (EST)
Subject: Re: [PATCH v3] cpm2_pic: Allow correct flow_types for port C
	interrupts
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4B20D81A.7010503@elphinstone.net>
Date: Thu, 10 Dec 2009 08:52:01 -0600
Message-Id: <9DDC31C7-6AEE-498C-BE18-C286C950BB51@kernel.crashing.org>
References: <4B20D81A.7010503@elphinstone.net>
To: Scott Wood <scottwood@freescale.com>, Mark Ware <mware@elphinstone.net>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 10, 2009, at 5:14 AM, Mark Ware wrote:

> Port C interrupts can be either falling edge, or either edge.
> Other external interrupts are either falling edge or active low.
> Tested on a custom 8280 based board.
> 
> Signed-off-by: Mark Ware <mware@elphinstone.net>
> ---
> Changed in v3:
> - Cosmetic improvements as suggested by Anton and Scott
> - Added tested note to changelog
> 
> arch/powerpc/sysdev/cpm2_pic.c |   28 +++++++++++++++++++++-------
> 1 files changed, 21 insertions(+), 7 deletions(-)

Scott, Anton do you want to add an Ack to this version?

- k
