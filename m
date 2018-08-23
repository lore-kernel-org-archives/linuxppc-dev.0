Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wmvW66MBzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 11:25:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Michal Hocko <mhocko@kernel.org>, Ram Pai <linuxram@us.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-mm <linux-mm@kvack.org>
Subject: Re: Odd SIGSEGV issue introduced by commit 6b31d5955cb29 ("mm,
 oom: fix potential data corruption when oom_reaper races with writer")
In-Reply-To: <7767bdf4-a034-ecb9-1ac8-4fa87f335818@c-s.fr>
References: <7767bdf4-a034-ecb9-1ac8-4fa87f335818@c-s.fr>
Date: Thu, 23 Aug 2018 11:25:56 +1000
Message-ID: <87o9dtlvq3.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Hello,
>
> I have an odd issue on my powerpc 8xx board.
>
> I am running latest 4.14 and get the following SIGSEGV which appears 
> more or less randomly.
>
> [    9.190354] touch[91]: unhandled signal 11 at 67807b58 nip 777cf114 
> lr 777cf100 code 30001
> [   24.634810] ifconfig[160]: unhandled signal 11 at 67ae7b58 nip 
> 77aaf114 lr 77aaf100 code 30001


It would be interesting to see the code dump here and which registers
are being used.

Can you backport the show unhandled signal changes and see what that
shows us?

cheers
