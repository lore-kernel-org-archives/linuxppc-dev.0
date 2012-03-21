Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 64D93B6FD5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 04:22:42 +1100 (EST)
Subject: Re: [PATCH v2] powerpc: document the FSL MPIC message register binding
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1330594354-31095-1-git-send-email-B38951@freescale.com>
Date: Wed, 21 Mar 2012 12:22:38 -0500
Message-Id: <7F5F9AA1-0976-4865-AB90-C29A6733AB6A@kernel.crashing.org>
References: <1330594354-31095-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 1, 2012, at 3:32 AM, Jia Hongtao wrote:

> This binding documents how the message register blocks found in some FSL
> MPIC implementations shall be represented in a device tree.
> 
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> ---
> Changes for v2:
> * Update compatible type from <string> to <string-list>.
> * Update interrupts description.
> * Update mpic-msgr-receive-mask description.

applied

- k
