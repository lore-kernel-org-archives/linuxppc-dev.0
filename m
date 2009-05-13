Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB73FDE0BE
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 08:10:31 +1000 (EST)
Message-Id: <5CAABE74-2F06-420C-B24A-A6EF63C023F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1242117363-14949-6-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 6/6] rio: fix section mismatch
Date: Wed, 13 May 2009 17:08:10 -0500
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
	<1242117363-14949-2-git-send-email-leoli@freescale.com>
	<1242117363-14949-3-git-send-email-leoli@freescale.com>
	<1242117363-14949-4-git-send-email-leoli@freescale.com>
	<1242117363-14949-5-git-send-email-leoli@freescale.com>
	<1242117363-14949-6-git-send-email-leoli@freescale.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 12, 2009, at 3:36 AM, Li Yang wrote:

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> drivers/rapidio/rio-scan.c |    6 +++---
> 1 files changed, 3 insertions(+), 3 deletions(-)


applied to next

- k
