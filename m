Return-Path: <sshtylyov@mvista.com>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF221B6FF4
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2012 20:41:24 +1000 (EST)
Received: by lbgc1 with SMTP id c1so179443lbg.15
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2012 03:41:20 -0700 (PDT)
Message-ID: <4FE1A8A9.1040307@mvista.com>
Date: Wed, 20 Jun 2012 14:40:41 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
 <20120620152759.2caceb8c.yuasa@linux-mips.org>
In-Reply-To: <20120620152759.2caceb8c.yuasa@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mundt <lethal@linux-sh.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Chris Zankel <chris@zankel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 20-06-2012 10:27, Yoichi Yuasa wrote:

> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578

    Please also specify the summary of that commit in parens.

> breaks all MIPS builds.

[...]

> Signed-off-by: Yoichi Yuasa<yuasa@linux-mips.org>

WBR, Sergei
