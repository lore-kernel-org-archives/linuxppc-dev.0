Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 0CE35DE108
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 22:30:21 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1986868ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 05:30:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090518235756.7a0b1061@lappy.seanm.ca>
References: <1241560385-26868-1-git-send-email-timur@freescale.com>
	<fa686aa40905140813l5caf7085r64bce935be0a22d3@mail.gmail.com>
	<4A0C40D4.1090508@freescale.com>
	<fa686aa40905140910i194acbd7y34142720874b8299@mail.gmail.com>
	<ed82fe3e0905181549n6d9a5370rcc0e1f52cebdc2d3@mail.gmail.com>
	<fa686aa40905181958ye89c1far6a53dc57cf650728@mail.gmail.com>
	<20090518235756.7a0b1061@lappy.seanm.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 19 May 2009 06:30:00 -0600
Message-ID: <fa686aa40905190530o165fd6daj4718e05472a1f176@mail.gmail.com>
Subject: Re: [PATCH v7] introduce macro spin_event_timeout()
To: Sean MacLennan <smaclennan@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 18, 2009 at 9:57 PM, Sean MacLennan <smaclennan@pikatech.com> w=
rote:
> On Mon, 18 May 2009 20:58:03 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> Then let it lie fallow on the list and in patchwork. =A0It is published,
>> and people know that it is available (I'll certainly consider it as I
>> do driver work), but there must be real (not just theoretical) in
>> kernel users of the interface. =A0I someone wants to use it, then they
>> can add it to their series or ping the list about getting it merged.
>
> That's too bad. If it is ever merged, could you also ping the list?

If you intend to use it, then post a patch to do so and state that it
depends on Timur's patch.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
