Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 28AC72C041B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2013 03:47:18 +1100 (EST)
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by muin.pair.com (Postfix) with ESMTPSA id E39CC8FC31
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 11:47:15 -0500 (EST)
Received: by mail-la0-f41.google.com with SMTP id fo12so1891022lab.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Mar 2013 08:47:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1362655668-26721-3-git-send-email-Sandeep@freescale.com>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
 <1362655668-26721-3-git-send-email-Sandeep@freescale.com>
Date: Fri, 8 Mar 2013 10:47:14 -0600
Message-ID: <CAOZdJXW7=3G8STRzaF04dmFZKFjp3=_2uy9F2pTZ-pe7L8nd7A@mail.gmail.com>
Subject: Re: [PATCH 3/4] TDM Device Tree entries for various Freescale
 Platforms
From: Timur Tabi <timur@tabi.org>
To: Sandeep Singh <Sandeep@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 7, 2013 at 5:27 AM, Sandeep Singh <Sandeep@freescale.com> wrote:
> arch/powerpc/boot/dts/p1022ds_36b.dts       |    3 +++

You forgot to update p1022ds_3b.dts.

> - * Copyright 2011 Freescale Semiconductor Inc.
> + * Copyright 2011-2012 Freescale Semiconductor Inc.

Do not update the copyright year in patches.

-- 
Timur Tabi
Linux kernel developer at Freescale
