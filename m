Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F19C21A000B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 12:10:21 +1100 (AEDT)
Message-ID: <1449623421.6028.13.camel@ellerman.id.au>
Subject: Re: [PATCH] sbc8641: drop bogus PHY IRQ entries from DTS file
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Lunn
 <andrew@lunn.ch>
Date: Wed, 09 Dec 2015 12:10:21 +1100
In-Reply-To: <1449614642-8161-1-git-send-email-paul.gortmaker@windriver.com>
References: <1449614642-8161-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-12-08 at 17:44 -0500, Paul Gortmaker wrote:

> This file was originally cloned off of the MPC8641D-HPCN reference
> platform, which actually had a PHY IRQ line connected.  However
> this board does not.  The bogus entry was largely inert and went
> undetected until commit 321beec5047af83db90c88114b7e664b156f49fe
> ("net: phy: Use interrupts when available in NOLINK state") was
> added to the tree.
> 
> With the above commit, the board fails to NFS boot since it sits
> waiting for a PHY IRQ event that of course never arrives.  Removing
> the bogus entries from the DTS file fixes the issue.

Commit 321beec5047a ("net: phy: Use interrupts when available in NOLINK state")
went into 4.4-rc2, so this is a fix for 4.4 right?

cheers
