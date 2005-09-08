Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC58168212
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Sep 2005 01:53:37 +1000 (EST)
In-Reply-To: <5B4F5836-F3E6-4511-BD4C-9388BBA715E0@freescale.com>
References: <20050908010428.GC8882@dmt.cnet>
	<5B4F5836-F3E6-4511-BD4C-9388BBA715E0@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d6ee02c1b27729ab87379f4205eec840@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 8 Sep 2005 11:53:17 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	"Gala Kumar K.-galak" <galak@freescale.com>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 8, 2005, at 10:11 AM, Kumar Gala wrote:

> Idea's on how to solve this are welcome.

Just create the appropriate defconfigs with this clock
frequency and check them in.

Thanks.

	-- Dan
