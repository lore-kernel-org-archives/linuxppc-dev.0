Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 917011007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 23:54:43 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <benh@kernel.crashing.org>, <greg@kroah.com>,
	<akpm@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-console@vger.kernel.org>
Subject: [PATCH 0/7] This patchset adds support for running Linux under the
	Freescale hypervisor,
Date: Thu, 19 May 2011 08:54:25 -0500
Message-ID: <1305813272-31826-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

have hypervisor extensions (e.g. the P4080 which has an e500mc core).

I think it makes sense for this patchset to go through Kumar Gala's -next 
branch, but I still need ACKs from various people on the parts that are
not e500-specific.

1. powerpc: make irq_choose_cpu() available to all PIC drivers
2. powerpc: introduce ePAPR embedded hypervisor hcall interface
3. powerpc: introduce the ePAPR embedded hypervisor vmpic driver
4. powerpc: add Freescale hypervisor partition control functions
5. powerpc/85xx: add board support for the Freescale hypervisor
6. tty/powerpc: introduce the ePAPR embedded hypervisor byte channel driver
7. drivers/misc: introduce Freescale hypervisor management driver

Ben Herrenschmidt, please review/ack parts 1-3.

Greg Kroah-Hartman, please review/ack part 6.

Andrew Morton, please review/ack part 7.

Thank you very much for looking at this patchset.  I hope to have it included 
in 2.6.40.
