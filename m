Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp-msa-out01.orange.fr (unknown [193.252.23.120])
	by ozlabs.org (Postfix) with ESMTP id 286BE67B83
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 15:06:22 +1000 (EST)
Date: Fri, 20 Oct 2006 07:02:47 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
Message-ID: <20061020050247.GA11168@powerlinux.fr>
References: <20061019122802.GA26637@aepfle.de> <45377ED3.9030001@bplan-gmbh.de>
	<1161308221.10524.92.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1161308221.10524.92.camel@localhost.localdomain>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 20, 2006 at 11:37:01AM +1000, Benjamin Herrenschmidt wrote:
> On CHRP with only a 8259, make sure it's set as the default host.

Hi Ben,

Where you able to investigate the interupt tree or at least look over the
lsprop output we sent you ? 

Friendly,

Sven Luther
