Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9705F1A0634
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 14:50:24 +1100 (AEDT)
Date: Thu, 6 Nov 2014 21:50:08 -0600
From: Scott Wood <scottwood@freescale.com>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: powerpc/8xx: Remove Kconfig symbol FADS
Message-ID: <20141107035008.GA25204@home.buserror.net>
References: <1411545979.19525.5.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1411545979.19525.5.camel@x220>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 24, 2014 at 10:06:19AM +0200, Paul Bolle wrote:
> Commit 39eb56da2b53 ("pcmcia: Remove m8xx_pcmcia driver") removed the
> only driver that used CONFIG_FADS. Setting the Kconfig symbol FADS is
> pointless since that commit. Remove it.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Done on top of next-20140923. Tested with "git grep" only.
> 
> Another cleanup might be to remove MPC8XXFADS (or "FADS") from the "8xx
> Machine Type" choice. Is there any reason left to pick "FADS" as a
> machine type?

Nothing references MPC8XXFADS, so yes, it can be removed.

-Scott
