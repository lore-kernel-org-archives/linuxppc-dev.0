Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A2CB0B6FA6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 21:32:32 +1100 (EST)
Message-ID: <1325068334.6632.43.camel@pasglop>
Subject: Re: linux-next: build failure after merge of the final tree
 (powerpc related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 28 Dec 2011 21:32:14 +1100
In-Reply-To: <20111228194949.ff20a609745e816c266f7d91@canb.auug.org.au>
References: <20111228194949.ff20a609745e816c266f7d91@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-12-28 at 19:49 +1100, Stephen Rothwell wrote:
> Hi ,
> 
> After merging the final tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> kernel/built-in.o: In function `irq_dispose_mapping':
> (.opd+0x159f0): multiple definition of `irq_dispose_mapping'
> arch/powerpc/kernel/built-in.o:(.opd+0x960): first defined here
> kernel/built-in.o: In function `irq_create_of_mapping':
> (.opd+0x15a20): multiple definition of `irq_create_of_mapping'
> arch/powerpc/kernel/built-in.o:(.opd+0x9a8): first defined here
> kernel/built-in.o: In function `.irq_create_of_mapping':
> (.text+0x147030): multiple definition of `.irq_create_of_mapping'
> arch/powerpc/kernel/built-in.o:(.text+0x9de0): first defined here
> kernel/built-in.o: In function `.irq_dispose_mapping':
> (.text+0x146f4c): multiple definition of `.irq_dispose_mapping'
> arch/powerpc/kernel/built-in.o:(.text+0x9684): first defined here
> 
> I am not sure what caused this. And have just left it broken.

Grant, is your irq remapper misbehaving ?

Cheers,
Ben.
