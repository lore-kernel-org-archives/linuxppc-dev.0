Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqhCl6M2DzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 13:34:59 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id t190so4115561pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 20:34:59 -0700 (PDT)
Date: Thu, 14 Jul 2016 13:34:49 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 herbert@gondor.apana.org.au, davem@davemloft.net,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Automatically load the vmx_crypto module if supported
Message-ID: <20160714033449.GB18277@balbir.ozlabs.ibm.com>
Reply-To: bsingharora@gmail.com
References: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
 <1468389299.4705.26.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1468389299.4705.26.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 03:54:59PM +1000, Alastair D'Silva wrote:
> On Wed, 2016-07-13 at 15:47 +1000, alastair@au1.ibm.com wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > > This series allows the vmx_crypto module to be detected and
> > automatically
> > loaded via UDEV if the CPU supports the vector crypto feature.
> > > Alastair D'Silva (2):
> >   powerpc: Add module autoloading based on CPU features
> >   crypto: vmx - Convert to CPU feature based module autoloading
> > >  arch/powerpc/Kconfig                  |  1 +
> >  arch/powerpc/include/asm/cpufeature.h | 70
> > +++++++++++++++++++++++++++++++++++
> >  drivers/crypto/vmx/Kconfig            |  2 +-
> >  drivers/crypto/vmx/vmx.c              |  6 +--
> >  4 files changed, 74 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/powerpc/include/asm/cpufeature.h
> 
> Please ignore the following:
>   [PATCH 1/2] Allow drivers to be autoloaded.
>   [PATCH 2/2] Automatically load the vmx_crypto module if supported.
>

Do you want to repost the series?

Balbir 
