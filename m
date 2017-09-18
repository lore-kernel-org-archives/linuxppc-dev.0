Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwm1166y8zDrVv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 22:44:37 +1000 (AEST)
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com
 [209.85.216.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E03E621C98
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 12:44:35 +0000 (UTC)
Received: by mail-qt0-f170.google.com with SMTP id b1so365973qtc.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 05:44:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505729319.6990.5.camel@abdul.in.ibm.com>
References: <1505729319.6990.5.camel@abdul.in.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 18 Sep 2017 07:44:14 -0500
Message-ID: <CAL_Jsq+Hoz-NrgxJ9sw0qr7FO9wNWv8p+Ch9GnrQuQRushciDA@mail.gmail.com>
Subject: Re: [linux-next][DLPAR CPU][Oops] Bad kernel stack pointer
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, mpe <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 18, 2017 at 5:08 AM, Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
> Hi,
>
> Dynamic CPU remove operation resulted in Kernel Panic on today's
> next-20170915 kernel.
>
> Machine Type: Power 7 PowerVM LPAR
> Kernel : 4.13.0-next-20170915

I assume this is not something new to 9/15 -next nor only in -next
because you also reported that 4.13.0 broke. Can you provide some
details on what version worked? 4.12?

Rob
