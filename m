Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id F1BCAB7D49
	for <linuxppc-dev@ozlabs.org>; Mon,  3 May 2010 00:23:44 +1000 (EST)
Received: by gwj17 with SMTP id 17so749809gwj.15
	for <linuxppc-dev@ozlabs.org>; Sun, 02 May 2010 07:23:42 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1272799482.4130.0@antares>
References: <1272392908.6504.0@antares> <1272799482.4130.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 2 May 2010 08:23:22 -0600
Message-ID: <p2sfa686aa41005020723xfa3b8a18s45ef07b058fa12f1@mail.gmail.com>
Subject: Re: mpc512x uart: testers wanted
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 2, 2010 at 5:24 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> w=
rote:
> Hi Grant:
>
> Am 27.04.10 20:28 schrieb(en) Albrecht Dre=DF:
>>>
>>> MPC5121e Hardware Design Guide provides correct info according to my
>>> tests using /16 and /10 prescaler. I've send a new patch with the fixed
>>> comments, unfortunately forgot to mark it as v4, but it is threaded to =
your
>>> v.3a patch and contains a small changelog, so I hope it is not a proble=
m.
>>
>> Grant? =A0Is this fine for you, or should I "officially" re-send it?
>
> *ping*
>
> IMHO, this issue can be closed now, as the correct uart operation has bee=
n
> verified on both the 512x (Anatolij) and 5200 (me) processors. =A0Do you
> accept Anatolij's "joint patch" he sent on Apr 26, or is that procedure t=
oo
> confusing? =A0And do we need further Acked-by's?

Yes, I'll pick up Anatolij's patch.  No further work needed by you.

g.
