Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB32C1A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 14:41:08 +1100 (AEDT)
Message-ID: <1447731640.3729.23.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 14/50] powerpc/powernv: M64 support on P7IOC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Date: Tue, 17 Nov 2015 14:40:40 +1100
In-Reply-To: <20151117030406.GB10142@gwshan>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-15-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D8A.2050505@ozlabs.ru> <20151117014203.GC31584@gwshan>
 <564A92E2.1040506@ozlabs.ru> <20151117030406.GB10142@gwshan>
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

On Tue, 2015-11-17 at 14:04 +1100, Gavin Shan wrote:
> 
> Sorry, you mean it's fine to break the code on P7IOC as it's going to be dead.
> But I'm curious when it's going happen, any idea about that?

Is it ? I think it's ok to not add support for M64, hotpug etc.... for
IODA1, but we can do that without *breaking* basic function that we
have today.

It's not completely dead, there are still a number of machines inside
of IBM with P7 that we can support for a little while longer (including
a few inside ozlabs).

Cheers,
Ben.
