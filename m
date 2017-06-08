Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkKcg2PvszDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 08:20:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Sahil Mehta <sahilmehta17@gmail.com>, John Allen <jallen@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Resend [PATCH] powerpc/hotplug-mem: Fix aa_index match bug for
 hotplug
In-Reply-To: <fa73f943-a8c7-f74b-fca8-20b7e53212ed@linux.vnet.ibm.com>
References: <fa73f943-a8c7-f74b-fca8-20b7e53212ed@linux.vnet.ibm.com>
Date: Fri, 09 Jun 2017 08:20:34 +1000
Message-ID: <87tw3qi0jx.fsf@concordia.ellerman.id.au>
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

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> When adding or removing memory, the aa_index (affinity value) for the
> memblock must also be converted to match the endianness of the rest
> of the 'ibm,dynamic-memory' property.  Otherwise, subsequent retrieval
> of the attribute will likely lead to non-existent nodes, followed by
> using the default node in the code inappropriately.
>
> Note: This is a bug that we would likely want to see fixed in stable
>       circa v4.1+.

I merged this a week ago:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-June/158426.html

It was annotated:

Fixes: 5f97b2a0d176 ("powerpc/pseries: Implement memory hotplug add in the kernel")
Cc: stable@vger.kernel.org # v4.1+

cheers
