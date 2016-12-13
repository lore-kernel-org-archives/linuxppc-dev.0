Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdBMm1KYPzDvhH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 18:36:04 +1100 (AEDT)
Received: by mail-yw0-x242.google.com with SMTP id r204so9453272ywb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 23:36:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161213060302.GB4109@naverao1-tp.localdomain>
References: <20161207174515.7628-1-prasannatsmkumar@gmail.com>
 <20161213060302.GB4109@naverao1-tp.localdomain>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Tue, 13 Dec 2016 13:06:00 +0530
Message-ID: <CANc+2y4rMh6WbN6VDSku=omVxfZ95S=V+cVdd+Kb_HMrk59z2g@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: sstep.c: Add modsw,
 moduw instruction emulation
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Ananth N <ananth@in.ibm.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Naveen,

>> Add modsw and moduw instruction emulation support to analyse_instr.
>> modsw is an x-form instruction that calculates signed modulo of values
>> stored in registers. moduw is similar to modsw but it works with
>> unsigned values.
>>
>> Changes in v2:
>> Don't update CR register as the instruction does not touch that
>> Arrange extended opcode in numerical order
>
> This changelog should come after '---' below so that it doesn't get
> included in the commit message.

Oh, I see. Should I send the patch again with the above change? If so
should I mark it v3 or just v2?

> Apart from that, for this patch:
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks and regards,
PrasannaKumar
