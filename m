Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x230.google.com (mail-pg0-x230.google.com
 [IPv6:2607:f8b0:400e:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3Yc803SYzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 18:19:36 +1000 (AEST)
Received: by mail-pg0-x230.google.com with SMTP id g2so27040299pge.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:19:35 -0700 (PDT)
Message-ID: <1492071568.8380.20.camel@gmail.com>
Subject: Re: [PATCH] powerpc/configs: Enable function trace by default
From: Balbir Singh <bsingharora@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 13 Apr 2017 18:19:28 +1000
In-Reply-To: <eea3c818-f5ca-4cd9-c715-307104534970@c-s.fr>
References: <20170413070309.10497-1-bsingharora@gmail.com>
 <eea3c818-f5ca-4cd9-c715-307104534970@c-s.fr>
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

On Thu, 2017-04-13 at 09:24 +0200, Christophe LEROY wrote:
> Hi Baldir

Hi Christophe, It's Balbir

> 
> Le 13/04/2017 à 09:03, Balbir Singh a écrit :
> > We expect to have these configs on by default, most
> > distros turn them off, its always good to have them on
> > so that we can use them and hopefully not break them
> 
> Isn't it the purpose of the target allyesconfig to allow such tests ?
> 

As a developer I don't use allyesconfig for submitting patches or testing
the kernel.

> FTRACE is quite CPU consumming, shouldn't it really be on by default ?

It does some work at boot to NOP out function entry points at _mcount
locations. Is that what you are referring to? Or the overhead of the
code in terms of size? Most distro kernels have tracing on by default.

The rest of the overhead is enablement based.

Thanks for the review!
Balbir Singh
