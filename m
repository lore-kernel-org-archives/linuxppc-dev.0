Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 859C7DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 13:58:53 +1000 (EST)
Message-Id: <8ACD6E82-11B1-45B9-8F82-1DAF5D245D11@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080429164112.GA11425@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] 86xx: mpc8610_hpcd: add support for PCI Express
	x8 slot
Date: Wed, 30 Apr 2008 22:58:44 -0500
References: <20080429164112.GA11425@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2008, at 11:41 AM, Anton Vorontsov wrote:
> This patch adds pcie node which is resposible for PCI-E x8 slot
> functioning. Though, this was tested using only x1 SKY2 NIC.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8610_hpcd.dts |   21 +++++++++++++++++++++
> 1 files changed, 21 insertions(+), 0 deletions(-)

applied.

- k
