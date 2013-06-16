Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA2212C007B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 09:02:25 +1000 (EST)
Message-ID: <1371423727.21896.144.camel@pasglop>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 17 Jun 2013 09:02:07 +1000
In-Reply-To: <1371355567.21896.101.camel@pasglop>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1371348007.21896.62.camel@pasglop> <1371353865.21896.94.camel@pasglop>
 <1371355567.21896.101.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-16 at 14:06 +1000, Benjamin Herrenschmidt wrote:
> Look at patches http://patchwork.ozlabs.org/patch/248920/ and followup,
> he basically walks the page tables here in a slightly different way than
> Paul does in H_ENTER. It's more like gup_fast. It will need to handle
> concurrent split/collapse etc... as well which it doesn't right now.
> 
> I'm considering merging Alexei stuff first (provided I don't find major
> problems with it), then you can provide a new THP series on top of it.

Ok, for now ignore Alexey stuff, there's enough issues in it that I can't
quite merge it yet. Just handle my other comments.

Cheers,
Ben.
