Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E00FDE8C0
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 05:27:12 +1000 (EST)
Message-Id: <29FCB4DB-9B38-4348-AF9D-FC7F659E7194@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1217271031-8922-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] Documentation: remove old sbc8260 board specific
	information
Date: Mon, 28 Jul 2008 14:24:55 -0500
References: <1217271031-8922-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org, rob@landley.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 28, 2008, at 1:50 PM, Paul Gortmaker wrote:

> This file contains 8 yr. old board specific information that was for
> the now gone ppc implementation, and it pre-dates widespread u-boot
> support.  Any of the technical details of the board memory map would  
> be
> more appropriately captured in a dts if I revive it as powerpc anyway.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Acked-by: Jason Wessel <jason.wessel@windriver.com>
> ---
> Documentation/powerpc/00-INDEX                   |    2 -
> Documentation/powerpc/SBC8260_memory_mapping.txt |  197  
> ----------------------
> 2 files changed, 0 insertions(+), 199 deletions(-)
> delete mode 100644 Documentation/powerpc/SBC8260_memory_mapping.txt

applied.

- k
