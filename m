Return-Path: <mikebwilliams@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BDE36B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 22:14:19 +1000 (EST)
Received: by fxe23 with SMTP id 23so154090fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 05:14:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110628114810.GA10237@zod.rchland.ibm.com>
References: <1308771051-30861-1-git-send-email-mike@mikebwilliams.com>
	<14e6cd940efae1704f5908757f81f627@kernel.crashing.org>
	<BANLkTikKNqEoQxGA642h14eOUjZ3hGZaQw@mail.gmail.com>
	<BANLkTinisHPrEN8Xc_KoqFwxknMooE=H4w@mail.gmail.com>
	<f3bf96d99dfc13e2ebc07d6ce2282f2e@kernel.crashing.org>
	<20110628114810.GA10237@zod.rchland.ibm.com>
Date: Tue, 28 Jun 2011 08:14:13 -0400
Message-ID: <BANLkTim7XYdeRQQ2fgAyx4s8ezZTJyZQkA@mail.gmail.com>
Subject: Re: [PATCH] powerpc, 460gt: Add 460gt as compatible in the check for
	460ex-compatible crypto
From: Mike Williams <mikebwilliams@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 28, 2011 at 7:48 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wr=
ote:
> On Fri, Jun 24, 2011 at 04:14:07AM +0200, Segher Boessenkool wrote:
>>>>>- =A0 =A0 =A0 if (of_find_compatible_node(NULL, NULL,
>>>>>"amcc,ppc460ex-crypto")) {
>>>>>+ =A0 =A0 =A0 if (of_find_compatible_node(NULL, NULL,
>>>>>"amcc,ppc460ex-crypto") ||
>>>>>+ =A0 =A0 =A0 =A0 =A0 of_find_compatible_node(NULL, NULL,
>>>>>"amcc,ppc460gt-crypto")) {
>>>>
>>>>If the device is actually compatible, the device tree node should
>>>>claim
>>>>it is, and you do not need this code change.
>>>
>>>That was actually my first instinct, however I tried to follow the
>>>current convention in the glacier and canyonlands DTS files, which is
>>>to set every device compatible to 460gt or 460ex, depending on the
>>>processor. Many of the devices are identical between the two, since
>>>they are variations of the same SoC, so which is the preferred method?
>>>Follow the device tree convention and add the compatibility check in
>>>the driver,
>>
>>That is not the convention.
>>
>>>or alter the device trees? I'll send another patch if it's
>>>the latter.
>>
>>You say
>>
>> =A0compatible =3D "amcc,ppc460gt-crypto", "amcc,ppc460ex-crypto";
>
> I went ahead and modified the addition of the node to the glacier DTS
> file to do this instead. =A0I think this specific patch can be dropped.
>
> josh
>

Thanks, go ahead and drop it. I got buried here at work with our
fiscal year ending.

Mike
