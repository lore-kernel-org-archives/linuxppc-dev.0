Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t798P1mLczDvLb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 10:11:01 +1100 (AEDT)
Received: by mail-oi0-x243.google.com with SMTP id v84so7940971oie.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 16:11:01 -0700 (PDT)
Date: Tue, 1 Nov 2016 08:09:53 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 Larry Finger <Larry.Finger@lwfinger.net>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] console: use first console if stdout-path device
 doesn't appear
Message-ID: <20161031230953.GA425@swordfish>
References: <87zill13z8.fsf@concordia.ellerman.id.au>
 <20161031121455.23280-1-paul.burton@imgtec.com>
 <1593250.MZpe3pfUW6@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1593250.MZpe3pfUW6@np-p-burton>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On (10/31/16 15:50), Paul Burton wrote:
[..]
> Actually whilst this fixes the output in QEMU it has other problems. I'm still 
> digging...

I propose a revert of '05fd007e46296', so you guys can find the
problem and fix it, not being under 'rc3' pressure.

	-ss
