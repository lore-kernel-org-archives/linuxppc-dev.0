Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 2BE5FB70D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 01:13:11 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] powerpc: cell: Fix axion_msi irq shutdown
Date: Tue, 28 Sep 2010 17:13:04 +0200
References: <alpine.LFD.2.00.1009281708350.2416@localhost6.localdomain6>
In-Reply-To: <alpine.LFD.2.00.1009281708350.2416@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201009281713.04348.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 28 September 2010, Thomas Gleixner wrote:
> Calling unmask_msi_irq on irq shutdown is at least suboptimal.
> Use mask_msi_irq instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
