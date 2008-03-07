Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFECBDDFDA
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 02:07:04 +1100 (EST)
Message-Id: <B1DF0FC4-7166-4A4D-9E43-7B8F740A3409@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1204564290-18283-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] fix QE firmware uploading limit
Date: Fri, 7 Mar 2008 09:06:47 -0600
References: <1204564290-18283-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 3, 2008, at 11:11 AM, Timur Tabi wrote:

> Fix a typo in qe_upload_firmware() that prevented uploading firmware  
> on
> systems with more than one RISC core.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch is for 2.6.25.
>
> arch/powerpc/sysdev/qe_lib/qe.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied.

- k
