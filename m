Return-Path: <htejun@gmail.com>
Received: from mail-yb0-x231.google.com (mail-yb0-x231.google.com
 [IPv6:2607:f8b0:4002:c09::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sg1c964cmzDshj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:07:53 +1000 (AEST)
Received: by mail-yb0-x231.google.com with SMTP id 2so50210933ybv.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 09:07:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 22 Sep 2016 12:07:49 -0400
From: Tejun Heo <tj@kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] percpu: improve generic percpu modify-return
 implementation
Message-ID: <20160922160749.GD1892@htj.duckdns.org>
References: <20160921085137.862-1-npiggin@gmail.com>
 <20160921205711.4e804777@roar.ozlabs.ibm.com>
 <20160921142343.GA10734@htj.duckdns.org>
 <20160922143500.21809b98@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160922143500.21809b98@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Sep 22, 2016 at 02:35:00PM +1000, Nicholas Piggin wrote:
> Well thank you, how about you?

Heh, can't complain.  Hope to see you around sometime.  It's been
forever.

> Trying a new mail client, sorry. It *seems* to be working now, how's
> this?

Hmm... Still encoded.

> From d0cb9052d6f4c31d24f999b7b0cecb34681eee9b Mon Sep 17 00:00:00 2001
> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Wed, 21 Sep 2016 18:23:43 +1000
> Subject: [PATCH] percpu: improve generic percpu modify-return implementations
> 
> Some architectures require an additional load to find the address of
> percpu pointers. In some implemenatations, the C aliasing rules do not
> allow the result of that load to be kept over the store that modifies
> the percpu variable, which causes additional loads.
> 
> Work around this by finding the pointer first, then operating on that.
> 
> It's also possible to mark things as restrict and those kind of games,
> but that can require larger and arch specific changes.

QP-decoded and applied to percpu/for-4.9.

Thanks.

-- 
tejun
