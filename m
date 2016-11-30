Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTCjd5bCXzDvpH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 19:08:53 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id e9so622436pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 00:08:53 -0800 (PST)
Date: Wed, 30 Nov 2016 19:08:19 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/8xx: xmon compile fix
Message-ID: <20161130190819.0bd8868a@roar.ozlabs.ibm.com>
In-Reply-To: <87fum9pfba.fsf@concordia.ellerman.id.au>
References: <20161129085654.1967-1-npiggin@gmail.com>
 <87fum9pfba.fsf@concordia.ellerman.id.au>
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

On Wed, 30 Nov 2016 19:00:57 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> 
> What's the actual error? mode/badaddr defined but not used?
> 
> I'm just curious why I've never hit it?

Yes exactly. I'm not sure why you wouldn't have seen it. I'm
using powerpc64 compiler to build 32-bit, but I don't think
that should make a difference for this warning.

Thanks,
Nick
