Return-Path: <Zumeng.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8138F1A075D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2015 12:00:42 +1000 (AEST)
Message-ID: <55A9B333.4030506@windriver.com>
Date: Sat, 18 Jul 2015 10:00:19 +0800
From: Zumeng Chen <zumeng.chen@windriver.com>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, paulus
 <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Zumeng Chen <zumeng.chen@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "romeo.cane.ext" <romeo.cane.ext@coriant.com>
Subject: Re: BUG: perf error on syscalls for powerpc64.
References: <CA+Y31wfLFe11nh9AVs2JgKrxpMc6qxxDyCfey52HT23S7RJ_zw@mail.gmail.com>
 <1437037461.15828.2.camel@ellerman.id.au>
 <CA+Y31wf16voXS6psDUDpNjMFTD8HTMwrdn=sDXC_B1=n7m=1FQ@mail.gmail.com>
 <20150717015104.GA25558@us.ibm.com>
 <1437098328-sup-6685@delenn.ozlabs.ibm.com>
In-Reply-To: <1437098328-sup-6685@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015年07月17日 09:59, Ian Munsie wrote:
> Excerpts from Sukadev Bhattiprolu's message of 2015-07-17 11:51:04 +1000:
>> Are you seeing this on big-endian or little-endian system?
>>
>> IIRC, I saw the opposite behavior on an LE system a few months ago.
>> i.e. without 1028ccf5, 'perf listf|grep syscall' failed.
>>
>> Applying 1028ccf5, seemed to fix it.
> You could be on to something there - IIRC the ABI was changed for LE to
> remove the dot symbols. Might be worth testing on both.

Yeah, thanks Ian for your hints. it should be the dot symbols. So I'll
believe it's good in 4.x, thanks Michael  for your patience as well.

Cheers,
Zumeng
>
> Cheers,
> -Ian
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
