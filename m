Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78F5ADDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 19:38:32 +1000 (EST)
In-Reply-To: <20070927183855.GA18226@loki.buserror.net>
References: <20070927183855.GA18226@loki.buserror.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6e14366ddae3dc1beb232269b4f24b09@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4] Make instruction dumping work in real mode.
Date: Fri, 28 Sep 2007 11:37:50 +0200
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

> On non-book-E-or-4xx, exceptions execute in real mode.  If a fault 
> happens
> that leads to a register dump, the kernel currently prints XXXXXXXX 
> because
> it doesn't realize that PC is a physical address.
>
> This patch checks the state of the IMMU, and if necessary converts PC 
> into a
> virtual address.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> OK, just CONFIG_BOOKE this time. :-P

You forgot to fix the commit message ;-P


Segher
