Return-Path: <scottwood@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9DD0B2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2013 06:08:34 +1100 (EST)
Message-ID: <1384542498.1403.238.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: Add a vga alias node for P1022
From: Scott Wood <scottwood@freescale.com>
To: Jason Jin <Jason.Jin@freescale.com>
Date: Fri, 15 Nov 2013 13:08:18 -0600
In-Reply-To: <1384495616-6684-1-git-send-email-Jason.Jin@freescale.com>
References: <1384495616-6684-1-git-send-email-Jason.Jin@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-11-15 at 14:06 +0800, Jason Jin wrote:
> In u-boot, when set the video as console, the name 'vga' is used
> as a general name for the video device, during the fdt_fixup_stdout
> process, the 'vga' name is used to search in the dtb to setup the
> 'linux,stdout-path' node. Though the P1022 DIU is not VGA-compatible device,
> to meet the 'vga' name used in u-boot, the vga alias node is added for
> P1022 in this patch. At the same time, a display alias is also added
> so that no other components grow dependencies on the vga alias node.

Please explain this in a brief code comment (e.g. /* inaccurate vga name
for U-Boot compatibility */), not just the commit message.

-Scott
