Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxyXG3QzMzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 21:42:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Rob Herring <robh@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [linux-next][DLPAR CPU][Oops] Bad kernel stack pointer
In-Reply-To: <1505729319.6990.5.camel@abdul.in.ibm.com>
References: <1505729319.6990.5.camel@abdul.in.ibm.com>
Date: Wed, 20 Sep 2017 21:42:21 +1000
Message-ID: <878th9lhpe.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:

> Hi,
>
> Dynamic CPU remove operation resulted in Kernel Panic on today's
> next-20170915 kernel.
>
> Machine Type: Power 7 PowerVM LPAR
> Kernel : 4.13.0-next-20170915
> config : attached
> test: DLPAR CPU remove
>
>
> dmesg logs:
> ----------
> cpu 37 (hwid 37) Ready to die...
> cpu 38 (hwid 38) Ready to die...
> cpu 39 (hwid 39)
> ******* RTAS CReady to die...
> ALL BUFFER CORRUPTION *******

Cool. Does that come from RTAS itself? I have never seen that happen
before.

Is this easily reproducible?

cheers
