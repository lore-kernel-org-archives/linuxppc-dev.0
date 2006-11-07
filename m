Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DD7567CE0
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 22:55:47 +1100 (EST)
Date: Tue, 7 Nov 2006 12:55:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 23/31] powerpc: Cell "Spider" MMIO workarounds
Message-ID: <20061107115541.GA32171@lst.de>
References: <1162884150.435786.961370643810.qpush@grosgo>
	<20061107072414.87D5F688CC@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061107072414.87D5F688CC@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2006 at 06:22:57PM +1100, Benjamin Herrenschmidt wrote:
> + * This driver adds basic cpufreq support for SMU & 970FX based G5 Macs,
> + * that is iMac G5 and latest single CPU desktop.

This doesn't make any sense ;-)
