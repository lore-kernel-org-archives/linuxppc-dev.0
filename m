Return-Path: <Zumeng.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53CE31A19B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 17:21:58 +1000 (AEST)
Message-ID: <55A8939C.3090606@windriver.com>
Date: Fri, 17 Jul 2015 13:33:16 +0800
From: Zumeng Chen <zumeng.chen@windriver.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: Michael Ellerman <mpe@ellerman.id.au>, <linux-kernel@vger.kernel.org>,
 <paulus@samba.org>, <imunsie@au1.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>, <romeo.cane.ext@coriant.com>
Subject: Re: BUG: perf error on syscalls for powerpc64.
References: <CA+Y31wfLFe11nh9AVs2JgKrxpMc6qxxDyCfey52HT23S7RJ_zw@mail.gmail.com>
 <1437037461.15828.2.camel@ellerman.id.au>
 <CA+Y31wf16voXS6psDUDpNjMFTD8HTMwrdn=sDXC_B1=n7m=1FQ@mail.gmail.com>
 <20150717015104.GA25558@us.ibm.com>
In-Reply-To: <20150717015104.GA25558@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015年07月17日 09:51, Sukadev Bhattiprolu wrote:
> Zumeng Chen [zumeng.chen@gmail.com] wrote:
> | 3. What I have seen in 3.14.x kernel,
> | ======================
> | And so far, no more difference to 4.x kernel from me about this part if
> | I'm right.
> |
> | *) With 1028ccf5
> |
> | perf list|grep -i syscall got me nothing.
> |
> |
> | *) Without 1028ccf5
> | root@localhost:~# perf list|grep -i syscall
> |    syscalls:sys_enter_socket                          [Tracepoint event]
> |    syscalls:sys_exit_socket                           [Tracepoint event]
> |    syscalls:sys_enter_socketpair                      [Tracepoint event]
> |    syscalls:sys_exit_socketpair                       [Tracepoint event]
> |    syscalls:sys_enter_bind                            [Tracepoint event]
> |    syscalls:sys_exit_bind                             [Tracepoint event]
> |    syscalls:sys_enter_listen                          [Tracepoint event]
> |    syscalls:sys_exit_listen                           [Tracepoint event]
> |    ... ...
>
> Are you seeing this on big-endian or little-endian system?

Big one.

>
> IIRC, I saw the opposite behavior on an LE system a few months ago.
> i.e. without 1028ccf5, 'perf listf|grep syscall' failed.

I wonder if this has anything to do with the bug.

Cheers,
Zumeng

>
> Applying 1028ccf5, seemed to fix it.
>
> Sukadev
>
