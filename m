Return-Path: <Marcin.Nowakowski@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp02.imgtec.com [217.156.133.132])
 by lists.ozlabs.org (Postfix) with ESMTP id 3svDjY4zzVzDsyS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 00:09:53 +1100 (AEDT)
Subject: Re: [PATCH v3 03/11] tracing/syscalls: add compat syscall metadata
To: Michael Ellerman <mpe@ellerman.id.au>, <linux-kernel@vger.kernel.org>
References: <1476182576-15247-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1476182576-15247-4-git-send-email-marcin.nowakowski@imgtec.com>
 <8737k254tc.fsf@concordia.ellerman.id.au>
CC: <linux-api@vger.kernel.org>, <luto@amacapital.net>, <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <f4ce7487-9285-c8a8-a3ed-32ec27034746@imgtec.com>
Date: Wed, 12 Oct 2016 15:09:49 +0200
MIME-Version: 1.0
In-Reply-To: <8737k254tc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12.10.2016 10:50, Michael Ellerman wrote:
> <...>
> It's annoying that we have to duplicate all that just to do a + 1.
>
> How about this as a precursor?
 > <...>

Thanks for the suggestion - unless anyone sees a reason to keep the 
current solution I'll change it.

Marcin
