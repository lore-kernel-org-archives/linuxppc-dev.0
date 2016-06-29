Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfXty1cpFzDqtL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:33:46 +1000 (AEST)
Message-ID: <1467182018.12626.1.camel@ellerman.id.au>
Subject: Re: linux-next: manual merge of the powerpc tree with Linus' tree
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thadeu Lima de Souza Cascardo
 <cascardo@redhat.com>
Date: Wed, 29 Jun 2016 16:33:38 +1000
In-Reply-To: <20160629052426.GB14508@naverao1-tp.localdomain>
References: <20160629103507.52c60714@canb.auug.org.au>
 <20160629052426.GB14508@naverao1-tp.localdomain>
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

On Wed, 2016-06-29 at 10:54 +0530, Naveen N. Rao wrote:
> On 2016/06/29 10:35AM, Stephen Rothwell wrote:
> > 
> > Today's linux-next merge of the powerpc tree got a conflict in:
> > 
> >   arch/powerpc/Kconfig
> > 
> > between commit:
> > 
> >   844e3be47693 ("powerpc/bpf/jit: Disable classic BPF JIT on ppc64le")
> 
> Ah, I see that the above commit is not part of powerpc next tree, which 
> explains the conflict.
 
I'll probably merge the fixes branch into next at some point, so then it will
be sorted.

> > I fixed it up (see below - I am not sure this entirely correct) and can

That resolution is fine.

cheers
