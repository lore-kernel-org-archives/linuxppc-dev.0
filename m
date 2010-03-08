Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 24E16B7CB9
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Mar 2010 11:45:44 +1100 (EST)
Received: by gyd10 with SMTP id 10so419141gyd.15
	for <linuxppc-dev@ozlabs.org>; Sun, 07 Mar 2010 16:45:43 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1267978529.2306.0@antares>
References: <1267978529.2306.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 7 Mar 2010 17:45:23 -0700
Message-ID: <fa686aa41003071645x70dff5d7s89db66416bcc4a0d@mail.gmail.com>
Subject: Re: mpc512x uart: testers wanted
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	=?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anatolij, could you please look into this?

Thanks,
g.

On Sun, Mar 7, 2010 at 9:15 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> w=
rote:
> Hi all,
>
> I recently posted a patch which improves the baud rate calculation on the
> mpc5200b. =A0Following requests by Grant and Wolfram, I added changes whi=
ch do
> also affect the mpc512x.
>
> Unfortunately, I don't have access to such a system, but IMHO the code (b=
oth
> the old implementation and my changes) contradict the data sheet. =A0Thus=
, it
> would be really helpful if you give give the code a try and report your
> experiences:
>
> <http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-March/080815.html>
>
> Thanks in advance,
> Albrecht.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
