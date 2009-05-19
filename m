Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 94751DE0C9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 12:58:24 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1886895ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 19:58:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ed82fe3e0905181549n6d9a5370rcc0e1f52cebdc2d3@mail.gmail.com>
References: <1241560385-26868-1-git-send-email-timur@freescale.com>
	<fa686aa40905140813l5caf7085r64bce935be0a22d3@mail.gmail.com>
	<4A0C40D4.1090508@freescale.com>
	<fa686aa40905140910i194acbd7y34142720874b8299@mail.gmail.com>
	<ed82fe3e0905181549n6d9a5370rcc0e1f52cebdc2d3@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 18 May 2009 20:58:03 -0600
Message-ID: <fa686aa40905181958ye89c1far6a53dc57cf650728@mail.gmail.com>
Subject: Re: [PATCH v7] introduce macro spin_event_timeout()
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 18, 2009 at 4:49 PM, Timur Tabi <timur@freescale.com> wrote:
> On Thu, May 14, 2009 at 11:10 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>> In other words, write your patches which use it and submit the lot as
>> a patch series with this patch as the first. =A0That gives some evidence
>> that this macro will actually be used and useful.
>
> This is going to be more difficult than you think. =A0The problem is
> that I don't have access to much hardware that uses drivers which can
> take advantage of this macro. =A0I can find one, maybe two examples, but
> if I put a timeout that's too short, I might break some other platform
> without knowing it.

Then let it lie fallow on the list and in patchwork.  It is published,
and people know that it is available (I'll certainly consider it as I
do driver work), but there must be real (not just theoretical) in
kernel users of the interface.  I someone wants to use it, then they
can add it to their series or ping the list about getting it merged.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
