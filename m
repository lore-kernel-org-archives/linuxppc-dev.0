Return-Path: <David.Daney@caviumnetworks.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4134EB6F62
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Jun 2012 03:54:18 +1000 (EST)
Message-ID: <4FE4B13E.10709@caviumnetworks.com>
Date: Fri, 22 Jun 2012 10:54:06 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
 <20120620152759.2caceb8c.yuasa@linux-mips.org>
 <20120620161249.GB29196@linux-mips.org>
In-Reply-To: <20120620161249.GB29196@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mundt <lethal@linux-sh.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>,
 Yoichi Yuasa <yuasa@linux-mips.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/20/2012 09:12 AM, Ralf Baechle wrote:
> On Wed, Jun 20, 2012 at 03:27:59PM +0900, Yoichi Yuasa wrote:
>
>> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
>
> Thanks, fix applied.
>

Where was it applied?

It doesn't show up in linux-next for 20120622, which is where it is needed.

David Daney
