Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3208DDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 10:09:49 +1000 (EST)
Date: Wed, 19 Sep 2007 04:09:40 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
Message-ID: <20070919040940.557ad12f@localhost.localdomain>
In-Reply-To: <46EFE300.1090108@ru.mvista.com>
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
	<46EFBEA6.4050406@ru.mvista.com>
	<20070918182704.640c677f@localhost.localdomain>
	<46EFE300.1090108@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Valentine,

On Tue, 18 Sep 2007 18:38:56 +0400
Valentine Barshak wrote:

> Well, thanks for the invitation :)
> I've been trying to work on the pci support here too. But I've used a 
> bit different approach. I tried to add 64-bit phys addr support to 
> pci_32.c. The patch seems to work on Sequoia. Actually, I thought 
> merging was too risky at this point and might cause more problems 
> breaking both 64 and 32-bit pci support.

In order not to break, we just need same functionality and it is not that complex.
I began with the upper approach as well, but that seems more like a workaround, than a step forward.

-- 
Sincerely, Vitaly
