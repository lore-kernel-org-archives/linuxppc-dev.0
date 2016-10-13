Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svlsh2SX2zDsyP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 20:33:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
 linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luto@amacapital.net, rostedt@goodmis.org,
 Ingo Molnar <mingo@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 03/11] tracing/syscalls: add compat syscall metadata
In-Reply-To: <f4ce7487-9285-c8a8-a3ed-32ec27034746@imgtec.com>
References: <1476182576-15247-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1476182576-15247-4-git-send-email-marcin.nowakowski@imgtec.com>
 <8737k254tc.fsf@concordia.ellerman.id.au>
 <f4ce7487-9285-c8a8-a3ed-32ec27034746@imgtec.com>
Date: Thu, 13 Oct 2016 20:33:40 +1100
Message-ID: <87r37kr3t7.fsf@concordia.ellerman.id.au>
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

Marcin Nowakowski <marcin.nowakowski@imgtec.com> writes:

> On 12.10.2016 10:50, Michael Ellerman wrote:
>> <...>
>> It's annoying that we have to duplicate all that just to do a + 1.
>>
>> How about this as a precursor?
>  > <...>
>
> Thanks for the suggestion - unless anyone sees a reason to keep the 
> current solution I'll change it.

Thanks. I forgot to add my SOB so here it is:

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
