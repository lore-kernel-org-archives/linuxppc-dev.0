Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y12y96Hb7zDsNH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 22:12:01 +1000 (AEST)
Received: by mail-pf0-x22f.google.com with SMTP id u12so3689109pfl.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 05:12:01 -0700 (PDT)
Date: Sun, 24 Sep 2017 14:19:22 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/3] powerpc:selftest update memcmp_64 selftest for
 VMX implementation
Message-ID: <20170924061922.GB10899@simonLocalRHEL7.x64>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-4-git-send-email-wei.guo.simon@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD007F112@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD007F112@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,
On Mon, Sep 25, 2017 at 09:30:28AM +0000, David Laight wrote:
> From: wei.guo.simon@gmail.com
> > Sent: 21 September 2017 00:35
> > This patch adjust selftest memcmp_64 so that memcmp selftest can be
> > compiled successfully.
> ...
> >  #define ITERATIONS 10000
> > 
> > +#define LARGE_SIZE (5 * 1024)
> > +#define LARGE_ITERATIONS 1000
> ...
> 
> Measuring performance by doing a lot of iterations isn't ideal
> and is pretty pointless.
> Cold cache performance can be more useful.
> Also you don't really want any dynamic branch prediction logic
> tuned to the exact test you keep doing.

I think the (orignal) selftest aims at full coverage of functionality
correctness, since each iteration generates a new data set by random.

Thanks,
- Simon
