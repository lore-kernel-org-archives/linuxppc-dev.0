Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 493A4DE1DE
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 05:47:30 +1000 (EST)
Date: Thu, 29 Mar 2007 14:43:55 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] qe: ucc_slow.guemr is in the wrong place
In-Reply-To: <1174937142750-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0703291443420.23408@localhost.localdomain>
References: <1174937142750-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 26 Mar 2007, Timur Tabi wrote:

> The definition of struct ucc_slow puts the guemr register immediately after the
> utpt register, when it should be at offset 0x90.  This patch adds the missing
> 0x52-byte padding.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  include/asm-powerpc/immap_qe.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>

applied

- k
