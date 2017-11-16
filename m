Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yckDL2YjzzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:29:05 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id f8so38963724qta.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 17:29:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAA9_cmcn=VyR3xZWOtxpko6+AhnjC1xqrYXsyz4Z5A+i2DfSbQ@mail.gmail.com>
References: <20171115175131.23631-1-oohall@gmail.com>
 <CAA9_cmcn=VyR3xZWOtxpko6+AhnjC1xqrYXsyz4Z5A+i2DfSbQ@mail.gmail.com>
From: Oliver <oohall@gmail.com>
Date: Thu, 16 Nov 2017 12:29:02 +1100
Message-ID: <CAOSf1CGuqiAfd3wFT4gwoCwPGBRBTzyM4nX8PAVBD-wXwRQ0QQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libnvdimm: Add of_node to region and bus descriptors
To: Dan Williams <dan.j.williams@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2017 at 5:05 AM, Dan Williams <dan.j.williams@gmail.com> wrote:
> On Wed, Nov 15, 2017 at 9:51 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
>> We want to be able to cross reference the region and bus devices
>> with the device tree node that they were spawned from. libNVDIMM
>> handles creating the actual devices for these internally, so we
>> need to pass in a pointer to the relevant node in the descriptor.
>>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>
> Looks ok to me,
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> ...this is late if you were expecting a 4.15 merge.

I'm not that optimistic, but I wouldn't complain.
