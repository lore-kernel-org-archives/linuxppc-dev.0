Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfSBm2sM7zDw5P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 20:02:40 +1100 (AEDT)
Date: Thu, 15 Dec 2016 09:54:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, gabriel@krisman.be,
 hch@lst.de, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, stable@vger.kernel.org.#.v4.9+
Subject: Re: [PATCH] genirq/affinity: fix node generation from cpumask
Message-ID: <20161215085456.GA2864@lst.de>
References: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(but I agree with the bracing nitpick from Gavin)
