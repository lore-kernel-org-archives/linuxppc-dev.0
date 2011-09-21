Return-Path: <cjb@laptop.org>
Received: from void.printf.net (void.printf.net [89.145.121.20])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97052B6F99
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Sep 2011 04:23:41 +1000 (EST)
From: Chris Ball <cjb@laptop.org>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
Date: Wed, 21 Sep 2011 13:53:27 -0400
In-Reply-To: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
	(Roy Zang's message of "Fri, 9 Sep 2011 20:05:46 +0800")
Message-ID: <m2pqit4wa0.fsf@bob.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Xu lei <B33228@freescale.com>, linux-mmc@vger.kernel.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Roy,

On Fri, Sep 09 2011, Roy Zang wrote:
> From: Xu lei <B33228@freescale.com>
>
> Freescale eSDHC registers only support 32-bit accesses,
> this patch ensures that all Freescale eSDHC register accesses
> are 32-bit.
>
> Signed-off-by: Xu lei <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Pushed to mmc-next for 3.2 with Anton's ACK now, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
