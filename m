Return-Path: <tinamdar@apm.com>
Received: from exprod5og102.obsmtp.com (exprod5og102.obsmtp.com [64.18.0.143])
 by ozlabs.org (Postfix) with SMTP id D261DB710E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 15:28:48 +1000 (EST)
Received: by yenl2 with SMTP id l2so2846558yen.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2012 22:28:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+5PVA4HGVGRbnLCMOAbO1mYnFCgHhh1_ErLdKq5YhMdV0VhQw@mail.gmail.com>
References: <1333956052-25319-1-git-send-email-tinamdar@apm.com>
 <1333956052-25319-2-git-send-email-tinamdar@apm.com>
 <CA+5PVA4HGVGRbnLCMOAbO1mYnFCgHhh1_ErLdKq5YhMdV0VhQw@mail.gmail.com>
Date: Wed, 9 May 2012 10:58:46 +0530
Message-ID: <CACoXjcn1H_Jov86a5fmonY-5CtKCcGgBHMwzUf-i-66-VatqJw@mail.gmail.com>
Subject: Re: [V2 2/5] powerpc: 40x: Add AHB, APB of_device_ids
From: Tanmay Inamdar <tinamdar@apm.com>
To: Josh Boyer <jwboyer@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 2, 2012 at 7:11 PM, Josh Boyer <jwboyer@gmail.com> wrote:
> On Mon, Apr 9, 2012 at 3:20 AM, Tanmay Inamdar <tinamdar@apm.com> wrote:
>> Adding of_device_id's for AHB and APB buses used in klondike (APM8018X) =
in
>> platforms/40x/ppc40x_simple.c file
>>
>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>
> You should probably combine the first 3 patches in this series into one
> patch. =A0Otherwise you run the risk of changing the DTS to something the
> kernel can't support. =A0At the least, this change should be patch 1 in
> the series, and you can probably combine the two DTS changes.
>

I will do it in next version of patches.

> josh

Thanks,
Tanmay
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, =

is for the sole use of the intended recipient(s) and contains information=
=A0
that is confidential and proprietary to AppliedMicro Corporation or its s=
ubsidiaries. =

It is to be used solely for the purpose of furthering the parties' busine=
ss relationship. =

All unauthorized review, use, disclosure or distribution is prohibited. =

If you are not the intended recipient, please contact the sender by reply=
 e-mail =

and destroy all copies of the original message.
=0D
