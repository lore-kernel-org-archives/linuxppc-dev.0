Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F34C8B71DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 15:02:03 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C4AADDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 15:02:02 +1000 (EST)
Message-Id: <49B70D0E-63FD-45B1-AA86-6EF330D11D06@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1242117363-14949-5-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 5/6] rio: warn_unused_result warnings fix
Date: Wed, 10 Jun 2009 23:34:03 -0500
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
	<1242117363-14949-2-git-send-email-leoli@freescale.com>
	<1242117363-14949-3-git-send-email-leoli@freescale.com>
	<1242117363-14949-4-git-send-email-leoli@freescale.com>
	<1242117363-14949-5-git-send-email-leoli@freescale.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 12, 2009, at 3:36 AM, Li Yang wrote:

> Adding failure path for the following two cases.
>
> warning: ignoring return value of 'device_add', declared with  
> attribute warn_unused_result
> warning: ignoring return value of 'sysfs_create_bin_file', declared  
> with attribute warn_unused_result
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> drivers/rapidio/rio-scan.c  |   44 +++++++++++++++++++++++++ 
> +----------------
> drivers/rapidio/rio-sysfs.c |    6 +++-
> 2 files changed, 31 insertions(+), 19 deletions(-)

applied w/fixup based on Andrew's comments.

- k
