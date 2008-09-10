Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id 3ACFADDF73
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 22:23:23 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2677809rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 05:23:21 -0700 (PDT)
Message-ID: <319b0ac50809100523t17da1035l95c67808bd75088@mail.gmail.com>
Date: Wed, 10 Sep 2008 14:23:20 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: IDE
In-Reply-To: <200809101304.51990.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5156_14654937.1221049400945"
References: <319b0ac50809100224w2073359aod42c843cd5696599@mail.gmail.com>
	<319b0ac50809100233n4a4f50e8y77b408aa9955058b@mail.gmail.com>
	<48C79BDE.6030905@ru.mvista.com> <200809101304.51990.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_5156_14654937.1221049400945
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I looked falconide.c, it uses     hw_regs_t hw; and ide_hwif_t *hwif.
Is it a good way ?

2008/9/10, Arnd Bergmann <arnd@arndb.de>:
>
> On Wednesday 10 September 2008, Sergei Shtylyov wrote:
> >    Most probably you can use the existing platform drivers:
> > drivers/ide/egacy/ide_platform.c or drivers/ata/pata_platform.c.
> > Create/register a platform device named "pata_platform" with 2 memory
> > and 1 IRQ resource, and enable one of those drivers.
>
>
> For new boards using a flattened device tree, it should be enough
> to add a device node for the pata_of_platform driver.
> If you need a device specific setup, you should add a new "compatible"
> value in the tree and make the driver handle that in whatever
> way you need.
>
>
>         Arnd <><
>

------=_Part_5156_14654937.1221049400945
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I looked falconide.c, it uses &nbsp;&nbsp;&nbsp; hw_regs_t hw; and ide_hwif_t *hwif. <br>
Is it a good way ?<br><br><div><span class="gmail_quote">2008/9/10, Arnd Bergmann &lt;<a href="mailto:arnd@arndb.de">arnd@arndb.de</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wednesday 10 September 2008, Sergei Shtylyov wrote:<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;Most probably you can use the existing platform drivers:<br> &gt; drivers/ide/egacy/ide_platform.c or drivers/ata/pata_platform.c.<br> &gt; Create/register a platform device named &quot;pata_platform&quot; with 2 memory<br>
 &gt; and 1 IRQ resource, and enable one of those drivers.<br> <br> <br>For new boards using a flattened device tree, it should be enough<br> to add a device node for the pata_of_platform driver.<br> If you need a device specific setup, you should add a new &quot;compatible&quot;<br>
 value in the tree and make the driver handle that in whatever<br> way you need.<br> <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Arnd &lt;&gt;&lt;<br> </blockquote></div><br>

------=_Part_5156_14654937.1221049400945--
