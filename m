Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-vk0-x22b.google.com (mail-vk0-x22b.google.com
 [IPv6:2607:f8b0:400c:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyZhc2Hy2zDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 15:51:12 +1000 (AEST)
Received: by mail-vk0-x22b.google.com with SMTP id r69so1603259vke.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 22:51:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170330071613.GE4762@naverao1-tp.localdomain>
References: <20170322193030.GA8008@bombadil.infradead.org>
 <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <d6a1a353de6a87bb5474ca9f1c1ff7ab2c4a1eb4.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <87mvc6b575.fsf@concordia.ellerman.id.au>
 <20170328102109.GC4762@naverao1-tp.localdomain>
 <87a884jow3.fsf@concordia.ellerman.id.au>
 <20170330071613.GE4762@naverao1-tp.localdomain>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Wed, 5 Apr 2017 11:21:09 +0530
Message-ID: <CANc+2y4v=3y=Wv+SUet4RvGDJ7JvoAfePyBEyajG4VvGh4ABzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: string: implement optimized memset variants
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30 March 2017 at 12:46, Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
> Also, with a simple module to memset64() a 1GB vmalloc'ed buffer, here
> are the results:
> generic:        0.245315533 seconds time elapsed        ( +-  1.83% )
> optimized:      0.169282701 seconds time elapsed        ( +-  1.96% )

Wondering what makes gcc not to produce efficient assembly code. Can
you please post the disassembly of C implementation of memset64? Just
for info purpose.

Thanks,
Prasanna
