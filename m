Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96AF01A08A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 14:57:35 +1100 (AEDT)
Message-ID: <1452657437.2403.17.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH V1 14/33] powerpc/mm: Use helper for finding pte
 bits mapping I/O area
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Denis Kirjanov <kda@linux-powerpc.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 13 Jan 2016 14:57:17 +1100
In-Reply-To: <CAOJe8K0sgNvOA5pP8jUt7rpfstW2d-hqOOjSXszihLDkpT4JXQ@mail.gmail.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1452582968-22669-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAOJe8K0sgNvOA5pP8jUt7rpfstW2d-hqOOjSXszihLDkpT4JXQ@mail.gmail.com>
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

On Tue, 2016-01-12 at 10:42 +0300, Denis Kirjanov wrote:
> > +static inline unsigned long pte_io_cache_bits(void)
> > +{
> > +     return _PAGE_NO_CACHE | _PAGE_GUARDED;
> > +}
> This could be just plain #define

Or just use pgprot_noncached()

Cheers,
Ben.
