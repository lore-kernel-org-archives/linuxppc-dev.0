Return-Path: <larry.finger@gmail.com>
Received: from mail-oi0-x22a.google.com (mail-oi0-x22a.google.com
 [IPv6:2607:f8b0:4003:c06::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t79cM5gF6zDvM1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 10:31:47 +1100 (AEDT)
Received: by mail-oi0-x22a.google.com with SMTP id 62so138436304oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 16:31:47 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v2] console: use first console if stdout-path device
 doesn't appear
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Paul Burton <paul.burton@imgtec.com>
References: <87zill13z8.fsf@concordia.ellerman.id.au>
 <20161031121455.23280-1-paul.burton@imgtec.com>
 <1593250.MZpe3pfUW6@np-p-burton> <20161031230953.GA425@swordfish>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
Date: Mon, 31 Oct 2016 18:31:43 -0500
MIME-Version: 1.0
In-Reply-To: <20161031230953.GA425@swordfish>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/31/2016 06:09 PM, Sergey Senozhatsky wrote:
> Hi,
>
> On (10/31/16 15:50), Paul Burton wrote:
> [..]
>> Actually whilst this fixes the output in QEMU it has other problems. I'm still
>> digging...
>
> I propose a revert of '05fd007e46296', so you guys can find the
> problem and fix it, not being under 'rc3' pressure.

If we were at -rc4 or -rc5, then I would agree; however, I think there is still 
time to fix the problem.

Larry
