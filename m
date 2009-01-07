Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id CE652DDF33
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 09:36:16 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2667661ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 14:36:15 -0800 (PST)
Message-ID: <fa686aa40901071436x35fb6c6ar3f711c53d7edf2bc@mail.gmail.com>
Date: Wed, 7 Jan 2009 15:36:14 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
In-Reply-To: <49652B79.5010502@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090107135457.234150@gmx.net> <20090107140132.140980@gmx.net>
	<fa686aa40901070841o3ede1d56tf5f69c33523513f4@mail.gmail.com>
	<20090107221028.GA18669@ld0162-tx32.am.freescale.net>
	<fa686aa40901071421w6c4aa48eyd869eb952373a74d@mail.gmail.com>
	<49652B79.5010502@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2009 at 3:23 PM, Scott Wood <scottwood@freescale.com> wrote:
> Grant Likely wrote:
>>
>> On Wed, Jan 7, 2009 at 3:10 PM, Scott Wood <scottwood@freescale.com>
>> wrote:
>>>
>>> Why?
>>
>> Defensive programming.  To not rely on implicit relationships
>
> It doesn't seem any more likely to introduce a fault by specifying the
> interrupt controller in one place than in many places.

We do the same thing with #address-cells and #size-cells for the same
reason.  You can get away with leaving them out; but being explicit is
more clear.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
