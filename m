Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25CAEDDF07
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 00:12:21 +1000 (EST)
Message-Id: <0F4E101E-6077-4C52-9460-8B0061059FD5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090403205846.GA20155@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] pq2fads: Update device tree for use with
	device-tree-aware u-boot.
Date: Mon, 6 Apr 2009 09:10:14 -0500
References: <20090403205846.GA20155@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 3, 2009, at 3:58 PM, Scott Wood wrote:

> Add aliases, and correct CS0 offset to match how u-boot
> programs it (this was not a problem with cuImage because
> the wrapper would reprogram the localbus to match the device
> tree).
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/boot/dts/pq2fads.dts |   20 ++++++++++++++------
> 1 files changed, 14 insertions(+), 6 deletions(-)

applied

- k
