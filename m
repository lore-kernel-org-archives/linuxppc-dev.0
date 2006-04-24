Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 1F649679F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Apr 2006 04:53:36 +1000 (EST)
In-Reply-To: <200604242151091399377@126.com>
References: <200604242151091399377@126.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <9866A56E-AF4C-477D-A035-E6D6A78A75D3@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: PPC exception 0x320
Date: Mon, 24 Apr 2006 13:55:05 -0500
To: jeanwelly <jeanwelly@126.com>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Could you try to be more specific?  What processor do you have, what =20
linux version are you running, and what do you mean exactly when you =20
say you "encountered PPC exception 0x320"?  As far as I know, the =20
powerpc architecture does not define an exception 0x320.  0x300 is =20
usually DSI on classic powerpc parts.  BookE parts handle things =20
differently.

Thanks,
-Becky

On Apr 24, 2006, at 8:51 AM, jeanwelly wrote:

> Hi,
> I encountered PPC exception 0x320, but don't know what it for. Any =20
> one could help me on this?
> Thanks!
>  			=09
>
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
jeanwelly
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
jeanwelly@126.com
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
=E3=80=80=E3=80=802006-04-24
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
