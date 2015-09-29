Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0139.outbound.protection.outlook.com [157.56.110.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 073B71A05C9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 10:38:28 +1000 (AEST)
Date: Mon, 28 Sep 2015 19:38:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 14/25] powerpc32: remove ioremap_base
Message-ID: <20150929003814.GL6161@home.buserror.net>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <82d78f31950ef7985d8f2bb57c88bb53f88b9e3c.1442939410.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <82d78f31950ef7985d8f2bb57c88bb53f88b9e3c.1442939410.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:50:56PM +0200, Christophe Leroy wrote:
> ioremap_base is not initialised and is nowhere used so remove it
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> No change in v2

Could you also clean up the references to ioremap_base in the comments?

-Scott
