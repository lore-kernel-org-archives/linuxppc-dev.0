Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hM325dbKzF2Sv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 15:19:10 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id bi12-v6so601533plb.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 22:19:10 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-70-78.tpgi.com.au. [59.102.70.78])
 by smtp.gmail.com with ESMTPSA id
 t80-v6sm8221pfg.0.2018.05.09.22.19.06
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 09 May 2018 22:19:07 -0700 (PDT)
Date: Thu, 10 May 2018 15:18:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/kbuild: set generic machine type for compile
 with 64-bit toolchain
Message-ID: <20180510151858.571d9f56@roar.ozlabs.ibm.com>
In-Reply-To: <20180510002637.3069-1-npiggin@gmail.com>
References: <20180510002637.3069-1-npiggin@gmail.com>
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

On Thu, 10 May 2018 10:26:37 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> The 64-bit toolchain uses the wrong ISA variant for compiling 32-bit
> kernels, eve with -m32. Set -mcpu=powerpc which is the generic 32-bit
> powerpc machine type and scheduling model. 32-bit platforms and CPUs
> can override this with -mcpu= options that come later on the command
> line.
> 
> This fixes a lot of build failures due to incompatible assembly when
> compiling 32-bit kernel with 64-bit toolchain.

Actually ignore this patch, it had a few other problems. I'll send a new
version out.

Thanks,
Nick
