Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B42B067A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 01:43:27 +1000 (EST)
In-Reply-To: <200604252303190264825@126.com>
References: <200604242151091399377@126.com>
	<9866A56E-AF4C-477D-A035-E6D6A78A75D3@freescale.com>
	<200604252303190264825@126.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <4819ACC0-1281-487B-B290-C55071E1EC27@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: PPC exception 0x320
Date: Tue, 25 Apr 2006 10:44:54 -0500
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

Is there some error message you can show me?

-B

On Apr 25, 2006, at 10:03 AM, jeanwelly wrote:

> Hi Becky Bruce,
> I'm using PPC 750... Just as you said, 0x300 is for DSI, and I =20
> guess they are a set of exceptions, not just one. And 0x320 is one =20
> of them.
> I got a board crash, and PPC alarmed exception 0x320. Could you =20
> show me the mechanism of handling of a special exception not one set.
> =09
>
> =3D=3D=3D=3D=3D=3D=3D 2006-04-25 02:53:35 =
=E6=82=A8=E5=9C=A8=E6=9D=A5=E4=BF=A1=E4=B8=AD=E5=86=99=E9=81=93=EF=BC=9A=3D=
=3D=3D=3D=3D=3D=3D
>
>> Could you try to be more specific?  What processor do you have, what
>> linux version are you running, and what do you mean exactly when you
>> say you "encountered PPC exception 0x320"?  As far as I know, the
>> powerpc architecture does not define an exception 0x320.  0x300 is
>> usually DSI on classic powerpc parts.  BookE parts handle things
>> differently.
>>
>> Thanks,
>> -Becky
>>
>> On Apr 24, 2006, at 8:51 AM, jeanwelly wrote:
>>
>>> Hi,
>>> I encountered PPC exception 0x320, but don't know what it for. Any
>>> one could help me on this?
>>> Thanks!
>>>  			=09
>>>
>>> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
jeanwelly
>>> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
jeanwelly@126.com
>>> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
=E3=80=80=E3=80=802006-04-24
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
>> .
>
> =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =
=3D =3D
> 		=09
>
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
=E8=87=B4
> =E7=A4=BC=EF=BC=81
>
> 			=09
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
jeanwelly
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
jeanwelly@126.com
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
=E3=80=80=E3=80=802006-04-25
>
