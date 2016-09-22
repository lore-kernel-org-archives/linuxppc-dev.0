Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfkQ23ttWzDsTQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 14:43:06 +1000 (AEST)
Received: by mail-pa0-x230.google.com with SMTP id hm5so25209541pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 21:43:06 -0700 (PDT)
Date: Thu, 22 Sep 2016 14:42:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] percpu: improve generic percpu modify-return
 implementation
Message-ID: <20160922144256.1b9d98c6@roar.ozlabs.ibm.com>
In-Reply-To: <alpine.DEB.2.20.1609211514440.18800@east.gentwo.org>
References: <20160921085137.862-1-npiggin@gmail.com>
 <20160921205711.4e804777@roar.ozlabs.ibm.com>
 <20160921142343.GA10734@htj.duckdns.org>
 <alpine.DEB.2.20.1609211514440.18800@east.gentwo.org>
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

On Wed, 21 Sep 2016 15:16:25 -0500 (CDT)
Christoph Lameter <cl@linux.com> wrote:

> On Wed, 21 Sep 2016, Tejun Heo wrote:
> 
> > Hello, Nick.
> >
> > How have you been? :)
> >  
> 
> He is baack. Are we getting SL!B? ;-)
> 

Hey Christoph. Sure, why not.
