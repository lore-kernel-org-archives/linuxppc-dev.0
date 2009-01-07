Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 636F2474C2
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 09:21:42 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2667833yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 14:21:40 -0800 (PST)
Message-ID: <fa686aa40901071421w6c4aa48eyd869eb952373a74d@mail.gmail.com>
Date: Wed, 7 Jan 2009 15:21:40 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
In-Reply-To: <20090107221028.GA18669@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090107135457.234150@gmx.net> <20090107140132.140980@gmx.net>
	<fa686aa40901070841o3ede1d56tf5f69c33523513f4@mail.gmail.com>
	<20090107221028.GA18669@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2009 at 3:10 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, Jan 07, 2009 at 09:41:14AM -0700, Grant Likely wrote:
>> > +                       8042@60 {
>> > +                               device_type = "8042";
>> > +                               reg = <1 0x00000060 0x00000001
>> > +                                      1 0x00000064 0x00000001>;
>> > +                               // IRQ1, IRQ12 (rising edge)
>> > +                               interrupts = <1 3 12 3>;
>>
>> For the flattened device tree, I think we've settled on the convention
>> that every node with an IRQ connection should have both the
>> interrupt-parent and interrupts properties.  (ie. don't rely on the
>> parent node's interrupt-parent property.)
>
> Why?

Defensive programming.  To not rely on implicit relationships

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
