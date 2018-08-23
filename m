Return-Path: <Grant.Likely@arm.com>
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wz2k6ymZzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 19:02:48 +1000 (AEST)
Subject: Re: DT case sensitivity
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rob Herring <robh@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>, Kumar Gala <kumar.gala@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Frank Rowand <frowand.list@gmail.com>, devicetree-spec@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
 <CAL_JsqKqkO31ekVMFKs+osLvKdZyDzRowF1thWXn5=tWhrJgvw@mail.gmail.com>
 <18175413a0148f7859ab36ed9715dce7a598f318.camel@kernel.crashing.org>
From: Grant Likely <grant.likely@arm.com>
Message-ID: <13bf5b39-0461-351e-57e3-60264eaa374d@arm.com>
Date: Thu, 23 Aug 2018 10:02:38 +0100
MIME-Version: 1.0
In-Reply-To: <18175413a0148f7859ab36ed9715dce7a598f318.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/08/2018 02:29, Benjamin Herrenschmidt wrote:
> On Wed, 2018-08-22 at 20:26 -0500, Rob Herring wrote:
>> On Wed, Aug 22, 2018 at 8:14 PM Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>>>
>>> On Wed, 2018-08-22 at 19:47 -0500, Rob Herring wrote:
>>>> The default DT string handling in the kernel is node names and
>>>> compatibles are case insensitive and property names are case sensitive
>>>> (Sparc is the the only variation and is opposite). It seems only PPC
>>>> (and perhaps only Power Macs?) needs to support case insensitive
>>>> comparisons. It was probably a mistake to follow PPC for new arches
>>>> and we should have made everything case sensitive from the start. So I
>>>> have a few questions for the DT historians. :)
>>>
>>> Open Firmware itself is insensitive.
>>
>> Doesn't it depend on the implementation? Otherwise, how is Sparc differe=
nt?
>
> Not sure ... Forth itself is insensitive for words but maybe not for
> string comparisons.

What problem are you trying to solve? I would think making everything
case insensitive would be the direction to go if you do anything. Least
possibility of breaking existing platforms in that scenario.

g.

>
>>
>>>> What PPC systems are case insensitive? Can we limit that to certain sy=
stems?
>>>
>>> All PowerMacs at least, the problem is that I don't have DT images or
>>> access to all the historical systems (and yes some people occasionally
>>> still use them) to properly test a change in that area.
>>
>> I'm temped to break them so I can find folks to provide me with DT dumps=
. :)
>
> I have a collection of DT dumps but I'm not sure about the legality of
> publishing them...
>
> Cheers,
> Ben.
>
>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
