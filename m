Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 122FFDDE3A
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 23:14:27 +1100 (EST)
Date: Thu, 18 Jan 2007 21:14:21 +0900 (JST)
Message-Id: <200701181214.l0ICELOm019925@toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 10/19] powerpc: Supporting PCI bus and base of I/O for
	Celleb
In-Reply-To: <1169080002.4965.13.camel@localhost.localdomain>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

> On Fri, 2007-01-12 at 10:03 +0900, Ishizaki Kou wrote:
> > This patch includes support for pci buses, base of Celleb specific
> > devices, and etc. It works on of_platform bus.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> 
> What is the status with dummy read and the problem with incorrect
> prefetch ? Do you have workaround for these ? Have you seen the hook
> mecanism I added in 2.6.20 for spider on IBM blades so we can do a dummy
> read after every readb/readw/readl ? You might want to use something
> similar.

Though we have recognized you had added hook mechanism, we did not
make any workaround for dummy read on this patch. So the problem still
remains. We will consider for the dummy read problem from now on.

We set prefetch OFF. So we don't have the prefetch problem. 

Best regards,
Kou Ishizaki
