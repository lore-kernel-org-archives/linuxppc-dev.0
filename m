Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C635F1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 21:51:23 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id pv5so260133pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 02:51:23 -0800 (PST)
Date: Wed, 27 Jan 2016 21:51:12 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
Message-ID: <20160127215112.080eec56@cotter.ozlabs.ibm.com>
In-Reply-To: <20160125170459.14DB7692CE@newverein.lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
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

On Mon, 25 Jan 2016 16:38:48 +0100
Torsten Duwe <duwe@lst.de> wrote:

> Changes since v5:
>   * extra "std r0,LRSAVE(r1)" for gcc-6
>     This makes the code compiler-agnostic.
>   * Follow Petr Mladek's suggestion to avoid
>     redefinition of HAVE_LIVEPATCH

I looked at the patches - well mostly patches 1 and 2, some quick questions

1. I know -mprofile-kernel is a big optimization win, do we need it or can
we incrementally add it?
2. Some of the hardcoded checks for opcode are hard to review, I know they've
been there in similar forms for a while. May be as an iterative step we should
give the numbers some meaning and use proper helpers for it.

I am going to give the patches a spin

Balbir Singh.
