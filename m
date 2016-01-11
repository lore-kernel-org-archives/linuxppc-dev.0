Return-Path: <tuliom@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A62871A0202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 02:16:52 +1100 (AEDT)
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tuliom@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 13:16:47 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8F3EF1DC0071
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 10:16:39 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BFEEuG32375180
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 13:14:15 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BFGg3D017881
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 13:16:42 -0200
From: "Tulio Magno Quites Machado Filho" <tuliom@linux.vnet.ibm.com>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: libc-alpha@sourceware.org, linuxppc-dev@lists.ozlabs.org,
 Steve Munroe <munroesj@linux.vnet.ibm.com>
Cc: 
Subject: Re: [PATCH] Add hwcap2 bits for POWER9
References: <568C272D.6000705@linux.vnet.ibm.com>
 <87egdsi4om.fsf@totoro.br.ibm.com>
 <1452267366.5201.12.camel@vnet.ibm.com> <568FE3D0.7080008@linaro.org>
Date: Mon, 11 Jan 2016 13:16:37 -0200
In-Reply-To: <568FE3D0.7080008@linaro.org> (Adhemerval Zanella's message of
 "Fri, 8 Jan 2016 14:29:04 -0200")
Message-ID: <87wprgdu3u.fsf@totoro.br.ibm.com>
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

Adhemerval Zanella <adhemerval.zanella@linaro.org> writes:

> On 08-01-2016 13:36, Peter Bergner wrote:
>> On Fri, 2016-01-08 at 11:25 -0200, Tulio Magno Quites Machado Filho wrote:
>>> Peter, this solves the issue you reported previously [1].
>>>
>>> [1] https://sourceware.org/ml/libc-alpha/2015-12/msg00522.html
>> 
>> Agreed, thanks.  I'll also add the POWER9 support to the GCC side
>> of the patch now that the glibc code is upstream.
>
> I do not see these bits being added in kernel side yet and GLIBC usual
> only sync these kind of bits *after* they are included in kernel side.
> So I would advise to either get these pieces (kernel support and hwcap
> advertise) in kernel before 2.23 release, otherwise revert the patches.

Ack.
It has just been sent to the correspondent Linux mailing list:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-January/137763.html

-- 
Tulio Magno
