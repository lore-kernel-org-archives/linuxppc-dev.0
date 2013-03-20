Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 576F82C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 16:02:08 +1100 (EST)
Message-ID: <1363755620.18880.27.camel@pasglop>
Subject: Re: [PATCH] [RFC] powerpc: Add VDSO version of time
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
Date: Wed, 20 Mar 2013 06:00:20 +0100
In-Reply-To: <5148C2B3.6010408@linux.vnet.ibm.com>
References: <5148C2B3.6010408@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-03-19 at 16:55 -0300, Adhemerval Zanella wrote:
> 
> I focused on 64 bit kernel, do I need to provide a scheme for 32 bits
> as well?

You did provide both 32 and 64-bit VDSO implementations so 32-bit
kernels should be covered.

Cheers,
Ben.
