Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjHw11m3HzDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 07:00:32 +1000 (AEST)
Message-ID: <1504126817.4974.22.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 1/3] powerpc/mm: Export flush_all_mm()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat
 <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
Date: Thu, 31 Aug 2017 07:00:17 +1000
In-Reply-To: <87inh519fl.fsf@concordia.ellerman.id.au>
References: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
 <87inh519fl.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-30 at 23:17 +1000, Michael Ellerman wrote:
> It's not clear why it makes sense for these to be empty. Either for the
> general idea of the "flush_all_mm()" API, or for your intended use by
> CXL.

Indeed. On hash we don't have a way to flush a PID out of the TLB,
but you can flush the whole LPID.

Cheers,
Ben.
