Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 4FEE5DE19D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 21:54:00 +1000 (EST)
Message-ID: <48049754.8010008@matrix-vision.de>
Date: Tue, 15 Apr 2008 13:53:56 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Flash on LocalBus @ MPC8343
References: <47FF802B.5020708@matrix-vision.de>	<20080411153849.GB2588@loki.buserror.net>	<47FFC2DE.80808@matrix-vision.de>
	<47FFC397.9040200@freescale.com>	<480079CA.5040000@matrix-vision.de>
	<20080414164518.GB7061@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080414164518.GB7061@ld0162-tx32.am.freescale.net>
Content-Type: multipart/alternative;
	boundary="------------050803030807080906090908"
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050803030807080906090908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Scott,

there has been a "compatible=3Dsoc" in my of_bus_id[] ...
It was taken from mpc834x_mds some weeks ago.

I changed to :

static struct of_device_id __initdata of_bus_ids[] =3D {
        { .compatible =3D "fsl,pq2pro-localbus", },
        {},
};


now it works fine.


Thanks !

Andre

Scott Wood schrieb:
> On Sat, Apr 12, 2008 at 10:58:50AM +0200, Andr=E9 Schwarz wrote:
>  =20
>> thanks , but ... can't find "of_bus_ids[]" entry.
>>    =20
>
> That means your platform likely isn't calling of_platform_bus_probe() a=
t
> all.  Look at other platforms, such as mpc831x_rdb, for an example.
>
>  =20
>> I'm obviously out of sync. My last git-pull from denx is 3 days old, n=
ow=20
>> - need to update on monday.
>>    =20
>
> For Denx-specific support, please contact Denx.
>
> This certainly isn't something that was added in the past 3 days.
>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>  =20



MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------050803030807080906090908
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Scott,<br>
<br>
there has been a "compatible=soc" in my of_bus_id[] ...<br>
It was taken from mpc834x_mds some weeks ago.<br>
<br>
I changed to :<br>
<br>
static struct of_device_id __initdata of_bus_ids[] = {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .compatible = "fsl,pq2pro-localbus", },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {},<br>
};<br>
<br>
<br>
now it works fine.<br>
<br>
<br>
Thanks !<br>
<br>
Andre<br>
<br>
Scott Wood schrieb:
<blockquote
 cite="mid:20080414164518.GB7061@ld0162-tx32.am.freescale.net"
 type="cite">
  <pre wrap="">On Sat, Apr 12, 2008 at 10:58:50AM +0200, Andr&eacute; Schwarz wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">thanks , but ... can't find "of_bus_ids[]" entry.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
That means your platform likely isn't calling of_platform_bus_probe() at
all.  Look at other platforms, such as mpc831x_rdb, for an example.

  </pre>
  <blockquote type="cite">
    <pre wrap="">I'm obviously out of sync. My last git-pull from denx is 3 days old, now 
- need to update on monday.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
For Denx-specific support, please contact Denx.

This certainly isn't something that was added in the past 3 days.

-Scott
_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a>
  </pre>
</blockquote>
<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------050803030807080906090908--
