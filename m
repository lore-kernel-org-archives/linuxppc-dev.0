Return-Path: <bsingharora@gmail.com>
Received: from mail-yw0-x233.google.com (mail-yw0-x233.google.com
 [IPv6:2607:f8b0:4002:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzr9h4NKrzDrWl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 20:01:28 +1000 (AEST)
Received: by mail-yw0-x233.google.com with SMTP id r9so52323858ywg.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 03:01:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469613238.5978.144.camel@kernel.crashing.org>
References: <48aad8b6-a27f-44c5-2b0b-f276595e9c04@gmail.com>
 <1469613238.5978.144.camel@kernel.crashing.org>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 27 Jul 2016 20:01:24 +1000
Message-ID: <CAKTCnz=YD_mf_c45_fWzjgaaVg+tC98LAxAr4Wu8FWr7At8BRQ@mail.gmail.com>
Subject: Re: [PATCH] Make system_reset_pSeries relocatable
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan S <svaidy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2016 at 7:53 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2016-07-27 at 17:32 +1000, Balbir Singh wrote:
>> From: Balbir Singh <bsingharora@gmail.com>
>>
>> Currently the power management bits are broken w.r.t. relocation.
>> There are direct branches from system_reset_pSeries to
>> power7_wakeup_*.
>
> Side track: we should really get rid of the _pSeries suffix for these
> things :-)
>

I thought about it, but then thought it would need more auditing
across places and hence held back. I'll be happy to send another patch
to remove _pSeries from the exception-64s.S to begin with as a follow
up

Balbir
