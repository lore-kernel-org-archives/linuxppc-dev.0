Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 115B02C034F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 07:50:06 +1000 (EST)
Date: Fri, 12 Jul 2013 16:49:55 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc: add Book E support to 64-bit hibernation
To: Dongsheng Wang <dongsheng.wang@freescale.com>
In-Reply-To: <1373605088-14537-1-git-send-email-dongsheng.wang@freescale.com>
 (from dongsheng.wang@freescale.com on Thu Jul 11 23:58:08 2013)
Message-ID: <1373665795.8183.289@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 11:58:08 PM, Dongsheng Wang wrote:
> +	/* Invalidate all tlbs */
> +	bl	_tlbil_all

Again, this will break on non-booke.

-Scott=
