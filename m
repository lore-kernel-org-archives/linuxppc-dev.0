Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.201])
	by ozlabs.org (Postfix) with ESMTP id 890C82BDB5
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2004 23:40:55 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so3363274rnk
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2004 06:40:50 -0700 (PDT)
Message-ID: <35fb2e59040923064034361b4a@mail.gmail.com>
Date: Thu, 23 Sep 2004 14:40:49 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Tonnerre <tonnerre@thundrix.ch>
In-Reply-To: <20040923045114.GF6889@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <35fb2e5904090607241087442d@mail.gmail.com>
	<35fb2e59040919131864c26952@mail.gmail.com>
	<35fb2e59040922181249d18af6@mail.gmail.com>
	<20040923045114.GF6889@thundrix.ch>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xsa_use_interrupts flag [WAS: xilinx_sysace]
Reply-To: jonathan@jonmasters.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 23 Sep 2004 06:51:14 +0200, Tonnerre <tonnerre@thundrix.ch> wrote:

> (No XSA_IRQ here!)

Cheers. I also left in a printk that shouldn't be there - just
adopting the early and often philosophy since this has been bothering
me for a while.

Jon.
