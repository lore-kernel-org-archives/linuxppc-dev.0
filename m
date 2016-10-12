Return-Path: <Marcin.Nowakowski@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp02.imgtec.com [217.156.133.132])
 by lists.ozlabs.org (Postfix) with ESMTP id 3svDkP6gpXzDt0Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 00:10:37 +1100 (AEDT)
Subject: Re: [PATCH v3 08/11] powerpc/tracing: fix compat syscall handling
To: Michael Ellerman <mpe@ellerman.id.au>, <linux-kernel@vger.kernel.org>
References: <1476182576-15247-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1476182576-15247-9-git-send-email-marcin.nowakowski@imgtec.com>
 <87zim951m9.fsf@concordia.ellerman.id.au>
CC: <linux-api@vger.kernel.org>, <luto@amacapital.net>, <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <f21ef656-6835-5539-c875-931614850555@imgtec.com>
Date: Wed, 12 Oct 2016 15:10:34 +0200
MIME-Version: 1.0
In-Reply-To: <87zim951m9.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12.10.2016 11:59, Michael Ellerman wrote:
> I went to test this and noticed the exit and enter events appear to be
> reversed in time? (your series on top of 24532f768121)

thanks for testing the patch - I've found a bug that has sneaked in 
while cleaning up the patches before submission ... I'll fix it in the 
next iteration.

Marcin
