Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSV9t3HWXzDqYn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 07:56:50 +1000 (AEST)
Message-ID: <1465768590.3022.10.camel@kernel.crashing.org>
Subject: Re: case sensitivity for devicetree node names
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@secretlab.ca>,
 David Gibson <david@gibson.dropbear.id.au>,
 "devicetree-spec@vger.kernel.org" <devicetree-spec@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Paul Mackerras
 <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 13 Jun 2016 07:56:30 +1000
In-Reply-To: <575DAC69.5010804@gmail.com>
References: <575B1D84.2010703@gmail.com> <575C68A1.1020701@gmail.com>
 <1465682743.19533.18.camel@kernel.crashing.org>
 <575DAC69.5010804@gmail.com>
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

On Sun, 2016-06-12 at 11:39 -0700, Frank Rowand wrote:
> 
> Is there a kernel config option (or a small set of config options)
> that would identify the affected machines?  It would be ok if
> the option(s) also included some non-affected machines.  That
> way we could use the case insensitive compare for a small
> set of machines.

Why do we want this ? Are there people really wanting to rely on case
difference between nodes ? That sounds fishy...

If you really want to do that, then CONFIG_PPC_PMAC would be your
test I suppose.

Cheers,
Ben.
