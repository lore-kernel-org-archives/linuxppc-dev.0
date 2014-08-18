Return-Path: <bobby.prani@gmail.com>
Received: from mail-lb0-x233.google.com (mail-lb0-x233.google.com
 [IPv6:2a00:1450:4010:c04::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A706E1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 07:08:52 +1000 (EST)
Received: by mail-lb0-f179.google.com with SMTP id v6so4687398lbi.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 14:08:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXxpnXPqoo6cT2tmXxHmFc1syMxWnrc-khGxytVi81s0g@mail.gmail.com>
References: <1408388465-26577-1-git-send-email-bobby.prani@gmail.com>
 <CAMuHMdXutLPeyDYHdRJ6Heb4vhtg=zMTpwOpKq1h4Yyk8exUSQ@mail.gmail.com>
 <CAJhHMCDE8e019oLvO7QEcAB-=yqkmgF4OS2VwRrJNV+vvXOe5Q@mail.gmail.com>
 <CAMuHMdXxpnXPqoo6cT2tmXxHmFc1syMxWnrc-khGxytVi81s0g@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 18 Aug 2014 17:08:18 -0400
Message-ID: <CAJhHMCBknUCxyf2QhHWxBZAijrLsFO+Gcyv-TZF9sUOASoyyWQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix build failure for PPC_32
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Gerhard Sittig <gsi@denx.de>,
 open list <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 18, 2014 at 4:57 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Note that PowerPC supports multi-platform kernels.
> A kernel with PPC_PSERIES and something else with PCI may still want to
> have floppy support.

OK, I tested with your change and it works. I needed to make one more
change for it compile all the way through though.

I will send both of the patches shortly.

-- 
Pranith
