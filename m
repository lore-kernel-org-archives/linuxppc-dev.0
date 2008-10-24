Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id DA5F3DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 04:12:28 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so900678rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 10:12:26 -0700 (PDT)
Message-ID: <fa686aa40810241012o57e85215i9778efc342250137@mail.gmail.com>
Date: Fri, 24 Oct 2008 11:12:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3] powerpc: Specify GPIO number base for controller in DT
In-Reply-To: <20081024165428.GC14350@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1224764850.4082.54.camel@galileo.recco.de>
	<D6AED5C1-6936-48BB-8D0F-98471C6841B0@kernel.crashing.org>
	<1224773378.4082.64.camel@galileo.recco.de>
	<200810232013.00539.sr@denx.de>
	<20081024165428.GC14350@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Wolfgang Ocker <weo@reccoware.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 24, 2008 at 10:54 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Oct 23, 2008 at 08:13:00PM +0200, Stefan Roese wrote:
>> On Thursday 23 October 2008, Wolfgang Ocker wrote:
>> > The GPIOLIB allows the specification of a base gpio number for a
>> > controller. That is not possible using OF. Instead, free gpio numbers
>> > are assigned.
>> >
>> > In order to allow static, predefined gpio numbers, a base property in
>> > the gpio controller node specifies the first gpio number.
>> >
>> > v2, v3: added/improved description of base property in doc
>>
>> These version descriptions are better placed below the "---" line. And you
>> should remove the "Re: " from the subject line. Other than this:
>>
>> Acked-by: Stefan Roese <sr@denx.de>
>
> Please-defer-this-patch-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>
> Wolfgang, Stefan, see this comment:
>
> http://ozlabs.org/pipermail/linuxppc-dev/2008-October/064505.html
>
> ..just tell me what are you trying to solve.

Yeah, I don't like this patch either.  GPIO numbering is a Linux
internal detail and has no bearing on the hardware description.  If
you need to know what a particular gpio number is then it should be
resolved by finding the device tree node; not by trying to fix a GPIO
controller to a particular number.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
