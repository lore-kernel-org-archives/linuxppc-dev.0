Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id D42D4DE314
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 01:05:34 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2538917wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 08:05:33 -0700 (PDT)
Message-ID: <319b0ac50809100805i5db8b9b7rb8cbc8d017ea58c5@mail.gmail.com>
Date: Wed, 10 Sep 2008 17:05:32 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: IDE
In-Reply-To: <48C7CC0F.9020003@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8429_5324105.1221059133022"
References: <319b0ac50809100224w2073359aod42c843cd5696599@mail.gmail.com>
	<319b0ac50809100233n4a4f50e8y77b408aa9955058b@mail.gmail.com>
	<48C79BDE.6030905@ru.mvista.com> <200809101304.51990.arnd@arndb.de>
	<48C7CC0F.9020003@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_8429_5324105.1221059133022
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok I will use the flat device tree.
Do you utils in order to use ata and check ata link ?
For example, to read some information of my compact flash

2008/9/10, Sergei Shtylyov <sshtylyov@ru.mvista.com>:
>
> Arnd Bergmann wrote:
>
>   Most probably you can use the existing platform drivers:
>>> drivers/ide/egacy/ide_platform.c or drivers/ata/pata_platform.c.
>>> Create/register a platform device named "pata_platform" with 2 memory and
>>> 1 IRQ resource, and enable one of those drivers.
>>>
>>
>  For new boards using a flattened device tree, it should be enough
>> to add a device node for the pata_of_platform driver.
>>
>
>   Oops, forgot about this one. No wonder, after being knee deep in ARM for
> several months. :-)
>
> MBR, Sergei
>

------=_Part_8429_5324105.1221059133022
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok I will use the flat device tree.<br>
Do you utils in order to use ata and check ata link ?<br>
For example, to read some information of my compact flash<br>
<br><div><span class="gmail_quote">2008/9/10, Sergei Shtylyov &lt;<a href="mailto:sshtylyov@ru.mvista.com">sshtylyov@ru.mvista.com</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<span class="q">Arnd Bergmann wrote:<br>
<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

 &nbsp;Most probably you can use the existing platform drivers: drivers/ide/egacy/ide_platform.c or drivers/ata/pata_platform.c.<br>
Create/register a platform device named &quot;pata_platform&quot; with 2 memory and 1 IRQ resource, and enable one of those drivers.<br>
</blockquote></blockquote>
<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
For new boards using a flattened device tree, it should be enough<br>
to add a device node for the pata_of_platform driver.<br>
</blockquote>
<br></span>
 &nbsp; Oops, forgot about this one. No wonder, after being knee deep in ARM for several months. :-)<br>
<br>
MBR, Sergei<br>
</blockquote></div><br>

------=_Part_8429_5324105.1221059133022--
