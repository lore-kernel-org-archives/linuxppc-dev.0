Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FRyt3GJ7zF1Kh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 23:41:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "qiang.zhao\@nxp.com" <qiang.zhao@nxp.com>,
 "york.sun\@nxp.com" <york.sun@nxp.com>
Subject: Re: [PATCH] QE GPIO: Add qe_gpio_set_multiple
In-Reply-To: <fef3d759a1f6677ec713b120b4b1f4ab1eb4946b.camel@infinera.com>
References: <20180619162216.20030-1-joakim.tjernlund@infinera.com>
 <VI1PR04MB1200BC4D8A8B362FE62B1D7591760@VI1PR04MB1200.eurprd04.prod.outlook.com>
 <fef3d759a1f6677ec713b120b4b1f4ab1eb4946b.camel@infinera.com>
Date: Tue, 26 Jun 2018 23:41:25 +1000
Message-ID: <87a7rh7ji2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund <Joakim.Tjernlund@infinera.com> writes:
> On Thu, 2018-06-21 at 02:38 +0000, Qiang Zhao wrote:
>> On 06/19/2018 09:22 AM, Joakim Tjernlund wrote:
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+qiang.zhao=3Dnxp.com@lis=
ts.ozlabs.org] On Behalf Of Joakim Tjernlund
>> Sent: 2018=E5=B9=B46=E6=9C=8820=E6=97=A5 0:22
>> To: York Sun <york.sun@nxp.com>; linuxppc-dev <linuxppc-dev@lists.ozlabs=
.org>
>> Subject: [PATCH] QE GPIO: Add qe_gpio_set_multiple
>>=20
>> This cousin to gpio-mpc8xxx was lacking a multiple pins method, add one.
>>=20
>> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
>> ---
>>  drivers/soc/fsl/qe/gpio.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
...
>>  static int qe_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)  {
>>         struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc); @@ -29=
8,6 +325,7 @@ static int __init qe_add_gpiochips(void)
>>                 gc->direction_output =3D qe_gpio_dir_out;
>>                 gc->get =3D qe_gpio_get;
>>                 gc->set =3D qe_gpio_set;
>> +               gc->set_multiple =3D qe_gpio_set_multiple;
>>=20
>>                 ret =3D of_mm_gpiochip_add_data(np, mm_gc, qe_gc);
>>                 if (ret)
>>=20
>> Reviewed-by: Qiang Zhao <qiang.zhao@nxp.com>
>>=20
>
> Who picks up this patch ? Is it queued somewhere already?

Not me.

cheers
