Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7FE1FB73BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 15:53:32 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1316806370-21067-1-git-send-email-agust@denx.de>
Date: Tue, 11 Oct 2011 23:53:26 -0500
Message-Id: <6EFB6D12-7505-4D3E-8FF9-033EF74FFB81@kernel.crashing.org>
References: <1316806370-21067-1-git-send-email-agust@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 23, 2011, at 2:32 PM, Anatolij Gustschin wrote:

> Remove wrong CONFIG_ prefix in Kconfig file.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> arch/powerpc/platforms/85xx/Kconfig |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied

- k
