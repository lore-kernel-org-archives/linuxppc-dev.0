Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FD461A0BA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 11:32:43 +1100 (AEDT)
Message-ID: <1424737962.2318.2.camel@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
From: Michael Ellerman <mpe@ellerman.id.au>
To: Julian Margetson <runaway@candw.ms>
Date: Tue, 24 Feb 2015 11:32:42 +1100
In-Reply-To: <54E78A12.7080409@candw.ms>
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
 <1424314594.22408.1.camel@ellerman.id.au> <54E55796.6000401@candw.ms>
 <54E78A12.7080409@candw.ms>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-20 at 15:25 -0400, Julian Margetson wrote:
> On 2/18/2015 11:25 PM, Julian Margetson wrote:

>  re PPC4XX PCI(E) MSI support.
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/087273.html

Hmm, I think all those comments were addressed before it was merged.

I tried to get a 4xx board going here last week, but it doesn't seem happy. I
can get a bit of uboot but then it hangs, might be overheating.

cheers
