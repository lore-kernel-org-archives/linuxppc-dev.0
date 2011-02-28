Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B372B6EFE
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Feb 2011 22:36:18 +1100 (EST)
Message-ID: <4D6B88C6.2000404@embedded-sol.com>
Date: Mon, 28 Feb 2011 13:36:38 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ira,

I've tried your patches with linux-2.6.38-rc6 on P2020RDB.
DMA test fails with the following errors if threads_per_chan != 1

dma0chan0-copy1: terminating after 1 tests, 1 failures (status 0)
dma0chan0-copy2: #0: test timed out

I've run the test like this:

modprobe dmatest threads_per_chan=2 iterations=1

Felix.
