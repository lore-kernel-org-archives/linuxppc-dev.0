Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3P274pttzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:53:03 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 34so5482041pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:53:03 -0700 (PDT)
Date: Thu, 13 Apr 2017 11:52:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: catch external interrupts going to host in
 POWER9
Message-ID: <20170413115247.7d82c10c@roar.ozlabs.ibm.com>
In-Reply-To: <1492032891.7236.70.camel@kernel.crashing.org>
References: <20170412131123.17445-1-npiggin@gmail.com>
 <1492004742.7236.58.camel@kernel.crashing.org>
 <20170413001252.250018c4@roar.ozlabs.ibm.com>
 <1492032891.7236.70.camel@kernel.crashing.org>
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

On Thu, 13 Apr 2017 07:34:51 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2017-04-13 at 00:12 +1000, Nicholas Piggin wrote:
> > Yeah sure that sounds good. How's this then?  
> 
> I suppose so :-) When I was testing all that I had a "b ." at 0x500 and
> 0x4500 and I didn't hit them :)

If only for the benefit of poorly configured systemsim users
like me. Could remove it when the dust settles.
