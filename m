Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D545DDE1B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 04:44:37 +1000 (EST)
In-Reply-To: <20070927183855.GA18226@loki.buserror.net>
References: <20070927183855.GA18226@loki.buserror.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7EEDB996-F029-47F6-B641-2881192694BF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4] Make instruction dumping work in real mode.
Date: Thu, 27 Sep 2007 13:44:33 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 27, 2007, at 1:38 PM, Scott Wood wrote:

> On non-book-E-or-4xx, exceptions execute in real mode.  If a fault  
> happens
> that leads to a register dump, the kernel currently prints XXXXXXXX  
> because
> it doesn't realize that PC is a physical address.
>
> This patch checks the state of the IMMU, and if necessary converts  
> PC into a
> virtual address.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
