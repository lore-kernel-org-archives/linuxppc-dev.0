Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtQhF4VCLzDqH9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 22:36:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>, Paul Mackerras <paulus@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2] powerpc: string: implement optimized memset variants
In-Reply-To: <20170328102109.GC4762@naverao1-tp.localdomain>
References: <20170322193030.GA8008@bombadil.infradead.org>
 <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <d6a1a353de6a87bb5474ca9f1c1ff7ab2c4a1eb4.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <87mvc6b575.fsf@concordia.ellerman.id.au>
 <20170328102109.GC4762@naverao1-tp.localdomain>
Date: Wed, 29 Mar 2017 22:36:28 +1100
Message-ID: <87a884jow3.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> I also tested zram today with the command shared by Wilcox:
>
> without patch:       1.493782568 seconds time elapsed    ( +-  0.08% )
> with patch:          1.408457577 seconds time elapsed    ( +-  0.15% )
>
> ... which also shows an improvement along the same lines as x86, as 
> reported by Minchan Kim.

I got:

  1.344847397 seconds time elapsed                                          ( +-  0.13% )

Using the C versions. Can you also benchmark those on your setup so we
can compare? So basically apply Matt's series but not your 2.

cheers
