Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id 2F22BDDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 18:30:13 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so260983rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 01:30:11 -0700 (PDT)
Message-ID: <319b0ac50809110130m71c5c640g15cc836a9e81f491@mail.gmail.com>
Date: Thu, 11 Sep 2008 10:30:11 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: IDE
In-Reply-To: <48C8B5F3.7050409@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8242_6151294.1221121811319"
References: <319b0ac50809100224w2073359aod42c843cd5696599@mail.gmail.com>
	<319b0ac50809100233n4a4f50e8y77b408aa9955058b@mail.gmail.com>
	<48C79BDE.6030905@ru.mvista.com> <200809101304.51990.arnd@arndb.de>
	<48C7CC0F.9020003@ru.mvista.com> <48C8B5F3.7050409@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_8242_6151294.1221121811319
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I saw pata_of_platform source. And when is called pata_of_platform_probe ?

2008/9/11, S=E9bastien Chr=E9tien <sebastien.chretien.enseirb@gmail.com>:
>
> Where can I find a pata_of_platform node example ?
>
> Sergei Shtylyov a =E9crit :
>
>> Arnd Bergmann wrote:
>>
>>   Most probably you can use the existing platform drivers:
>>>> drivers/ide/egacy/ide_platform.c or drivers/ata/pata_platform.c.
>>>> Create/register a platform device named "pata_platform" with 2 memory
>>>> and 1 IRQ resource, and enable one of those drivers.
>>>>
>>>
>>  For new boards using a flattened device tree, it should be enough
>>> to add a device node for the pata_of_platform driver.
>>>
>>
>>   Oops, forgot about this one. No wonder, after being knee deep in ARM f=
or
>> several months. :-)
>>
>> MBR, Sergei
>>
>>

------=_Part_8242_6151294.1221121811319
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I saw pata_of_platform source. And when is called pata_of_platform_probe ?<=
br><br><div><span class=3D"gmail_quote">2008/9/11, S=E9bastien Chr=E9tien &=
lt;<a href=3D"mailto:sebastien.chretien.enseirb@gmail.com">sebastien.chreti=
en.enseirb@gmail.com</a>&gt;:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Where can I find a pata_of_platform node example ?<br>
<br>
Sergei Shtylyov a =E9crit :<div><span class=3D"e" id=3D"q_11c50080082cea36_=
1"><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Arnd Bergmann wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

 &nbsp;Most probably you can use the existing platform drivers: drivers/ide=
/egacy/ide_platform.c or drivers/ata/pata_platform.c.<br>
Create/register a platform device named &quot;pata_platform&quot; with 2 me=
mory and 1 IRQ resource, and enable one of those drivers.<br>
</blockquote></blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
For new boards using a flattened device tree, it should be enough<br>
to add a device node for the pata_of_platform driver.<br>
</blockquote>
<br>
 &nbsp; Oops, forgot about this one. No wonder, after being knee deep in AR=
M for several months. :-)<br>
<br>
MBR, Sergei<br>
<br>
</blockquote>
</span></div></blockquote></div><br>

------=_Part_8242_6151294.1221121811319--
