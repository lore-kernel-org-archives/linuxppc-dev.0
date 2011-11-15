Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 937B6B6F93
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 09:15:15 +1100 (EST)
Message-ID: <4EC2E42B.1090600@freescale.com>
Date: Tue, 15 Nov 2011 16:14:03 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/p1023: set IRQ[4:6, 11] to high level sensitive
 for PCIe
References: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
 <45E28F47-CC83-4059-959F-E890049F416B@kernel.crashing.org>
In-Reply-To: <45E28F47-CC83-4059-959F-E890049F416B@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/15/2011 03:51 PM, Kumar Gala wrote:
> 
> On Nov 7, 2011, at 2:32 AM, Roy Zang wrote:
> 
> Should be setting ALL PCIe interrupts to '2'?  As I think in general
> we say these PCIe are 'active high'.  The only reason I would think
> we would NOT do this is if they are shared with some external device
> that is 'active low'.  If so we should comment that somewhere (maybe
> in the .dts, maybe just in the commit message).

I'd assume the ones that are pinned out are pulled high on the board.
Active-low is normal, it's these non-pinned-out "external" interrupts
that are pulled low inside the SoC that are weird.

-Scott
