Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS0hM3RK3zDvdr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 19:48:35 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id i88so6101853pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 00:48:35 -0800 (PST)
Date: Mon, 28 Nov 2016 19:48:22 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Leonidas S . Barbosa"
 <leosilva@linux.vnet.ibm.com>, linux-crypto@vger.kernel.org, Paulo Flabiano
 Smorigo <pfsmorigo@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] crypto: vmx - rebuild generated asm when target changes
Message-ID: <20161128194822.08e42907@roar.ozlabs.ibm.com>
In-Reply-To: <20161128082136.GD29256@naverao1-tp.localdomain>
References: <20161126042459.1964-1-npiggin@gmail.com>
 <20161128082136.GD29256@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 28 Nov 2016 13:51:36 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2016/11/26 03:24PM, Nicholas Piggin wrote:
> > Switching from big endian to little endian can fail to regenerate
> > the crypto assembly properly. Switch to using standard form of
> > kbuild dependency checking (i.e., use FORCE and if_changed).
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> 
> Hi Nick,
> A similar patch is already in:
> https://mid.mail-archive.com/linux-crypto@vger.kernel.org/msg21855.html
> 
> - Naveen
> 

Hi Naveen,

I didn't notice your patch, thanks for pointing it out.

Thanks,
Nick
