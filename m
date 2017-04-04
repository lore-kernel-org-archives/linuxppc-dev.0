Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy48Y1fBczDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 19:55:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: benh@au1.ibm.com, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/misc: fix exported functions that reference the
 TOC
In-Reply-To: <1491257105.4166.12.camel@au1.ibm.com>
References: <20170403032512.22085-1-oohall@gmail.com>
 <87r319vctk.fsf@concordia.ellerman.id.au>
 <1491257105.4166.12.camel@au1.ibm.com>
Date: Tue, 04 Apr 2017 19:55:05 +1000
Message-ID: <87shlov6o6.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@au1.ibm.com> writes:

> On Mon, 2017-04-03 at 23:29 +1000, Michael Ellerman wrote:
>> The other option would be just to make a rule that anything EXPORT'ed
>> must use _GLOBAL_TOC().
>
> Can we enforce that somewhat at build time ?

Yeah I had a quick look at doing that last night but didn't see anything
obvious.

So yes we could, but perhaps not easily - EXPORT_SYMBOL() is generic
code so changing that could be a pain.

cheers
