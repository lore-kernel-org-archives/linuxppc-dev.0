Return-Path: <srs0=j/st=kx=gmx.com=dominik.klein@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lpZm50pJzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 21:10:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41lpZm4CyHz8tD9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 21:10:24 +1000 (AEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41lpZl2WKRz9ryt
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2018 21:10:23 +1000 (AEST)
Subject: Re: [PATCH] of/fdt: Remove PPC32 longtrail hack in memory scan
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <20180727053555.26596-1-mpe@ellerman.id.au>
 <CAMuHMdVPmDG5m4C5=Y8yJYdwnWmXJJqQO1Hxa-3oncou9WCPzw@mail.gmail.com>
From: Dominik Klein <dominik.klein@gmx.com>
Message-ID: <ccb2a497-8ba1-d83c-c5fc-ca81d3a140aa@gmx.com>
Date: Wed, 8 Aug 2018 13:09:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVPmDG5m4C5=Y8yJYdwnWmXJJqQO1Hxa-3oncou9WCPzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys,

On 08.08.2018 11:29, Geert Uytterhoeven wrote:
> [...]
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> However, recently Dominik (CC) send me an enquiry about it, so perhaps
> he is a happy user?

Nope - don't have one either, so go ahead :)


Regards,
Dominik
