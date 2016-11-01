Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7JR25NvDzDvNg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 15:39:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Paul Burton <paul.burton@imgtec.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 Larry Finger <Larry.Finger@lwfinger.net>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] console: use first console if stdout-path device
 doesn't appear
In-Reply-To: <20161031230953.GA425@swordfish>
References: <87zill13z8.fsf@concordia.ellerman.id.au>
 <20161031121455.23280-1-paul.burton@imgtec.com>
 <1593250.MZpe3pfUW6@np-p-burton> <20161031230953.GA425@swordfish>
Date: Tue, 01 Nov 2016 15:39:10 +1100
Message-ID: <8737jbq0ep.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sergey Senozhatsky <sergey.senozhatsky@gmail.com> writes:
> On (10/31/16 15:50), Paul Burton wrote:
> [..]
>> Actually whilst this fixes the output in QEMU it has other problems. I'm still 
>> digging...
>
> I propose a revert of '05fd007e46296', so you guys can find the
> problem and fix it, not being under 'rc3' pressure.

Yeah I agree. The v2 fix doesn't work for me either.

Paul are you OK with that? And if so are you happy to send a revert to
Linus?

cheers
