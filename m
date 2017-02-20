Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRSPp0yp1zDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 13:34:22 +1100 (AEDT)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vRSPn1L2hz9s7s
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 13:34:20 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id o64so8060566pfb.1
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 18:34:20 -0800 (PST)
Date: Mon, 20 Feb 2017 12:34:03 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH 4/9] powerpc/4xx: Create 4xx pseudo-platform in
 platforms/4xx
Message-ID: <20170220123403.41239bbc@roar.ozlabs.ibm.com>
In-Reply-To: <1487313139-21959-4-git-send-email-mpe@ellerman.id.au>
References: <1487313139-21959-1-git-send-email-mpe@ellerman.id.au>
 <1487313139-21959-4-git-send-email-mpe@ellerman.id.au>
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

On Fri, 17 Feb 2017 17:32:14 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> We have a lot of code in sysdev for supporting 4xx, ie. either 40x or
> 44x. Instead it would be cleaner if it was all in platforms/4xx.
> 
> This is slightly odd in that we don't actually define any machines in
> the 4xx platform, as is usual for a platform directory. But still it
> seems like a better result to have all this related code in a directory
> by itself.

What about the other things in sysdev that support multiple platforms?
Why not just put the new 4xx subdirectory under sysdev?

The other patches all seem okay to me. Do you have any grand plan for
further breaking up traps.c?

Thanks,
Nick
