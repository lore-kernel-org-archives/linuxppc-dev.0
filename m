Return-Path: <york.sun@nxp.com>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Knz76bCWzF1Mm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 01:26:43 +1000 (AEST)
From: York Sun <york.sun@nxp.com>
To: "jocke@infinera.com" <joakim.tjernlund@infinera.com>, Leo Li
 <leoyang.li@nxp.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, Qiang Zhao <qiang.zhao@nxp.com>
Subject: Re: [PATCH] QE GPIO: Add qe_gpio_set_multiple
Date: Tue, 3 Jul 2018 15:26:37 +0000
Message-ID: <VI1PR04MB2078C55EBFAEED9BC3FCE1989A420@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <20180619162216.20030-1-joakim.tjernlund@infinera.com>
 <VI1PR04MB1200BC4D8A8B362FE62B1D7591760@VI1PR04MB1200.eurprd04.prod.outlook.com>
 <fef3d759a1f6677ec713b120b4b1f4ab1eb4946b.camel@infinera.com>
 <87a7rh7ji2.fsf@concordia.ellerman.id.au>
 <b7c4d55627e474a868ad7284672fbbd14dcf8d39.camel@infinera.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+Leo=0A=
=0A=
On 07/03/2018 03:30 AM, Joakim Tjernlund wrote:=0A=
> On Tue, 2018-06-26 at 23:41 +1000, Michael Ellerman wrote:=0A=
>>=0A=
>> Joakim Tjernlund <Joakim.Tjernlund@infinera.com> writes:=0A=
>>> On Thu, 2018-06-21 at 02:38 +0000, Qiang Zhao wrote:=0A=
>>>> On 06/19/2018 09:22 AM, Joakim Tjernlund wrote:=0A=
>>>> -----Original Message-----=0A=
>>>> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+qiang.zhao=3Dnxp.com@l=
ists.ozlabs.org] On Behalf Of Joakim Tjernlund=0A=
>>>> Sent: 2018=1B$BG/=1B(B6=1B$B7n=1B(B20=1B$BF|=1B(B 0:22=0A=
>>>> To: York Sun <york.sun@nxp.com>; linuxppc-dev <linuxppc-dev@lists.ozla=
bs.org>=0A=
>>>> Subject: [PATCH] QE GPIO: Add qe_gpio_set_multiple=0A=
>>>>=0A=
>>>> This cousin to gpio-mpc8xxx was lacking a multiple pins method, add on=
e.=0A=
>>>>=0A=
>>>> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>=0A=
>>>> ---=0A=
>>>>  drivers/soc/fsl/qe/gpio.c | 28 ++++++++++++++++++++++++++++=0A=
>>>>  1 file changed, 28 insertions(+)=0A=
>>=0A=
>> ...=0A=
>>>>  static int qe_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)  {=
=0A=
>>>>         struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc); @@ -=
298,6 +325,7 @@ static int __init qe_add_gpiochips(void)=0A=
>>>>                 gc->direction_output =3D qe_gpio_dir_out;=0A=
>>>>                 gc->get =3D qe_gpio_get;=0A=
>>>>                 gc->set =3D qe_gpio_set;=0A=
>>>> +               gc->set_multiple =3D qe_gpio_set_multiple;=0A=
>>>>=0A=
>>>>                 ret =3D of_mm_gpiochip_add_data(np, mm_gc, qe_gc);=0A=
>>>>                 if (ret)=0A=
>>>>=0A=
>>>> Reviewed-by: Qiang Zhao <qiang.zhao@nxp.com>=0A=
>>>>=0A=
>>>=0A=
>>> Who picks up this patch ? Is it queued somewhere already?=0A=
>>=0A=
>> Not me.=0A=
> =0A=
> York? You seem to be the only one left.=0A=
> =0A=
=0A=
I am not a Linux maintainer. Even I want to, I can't merge this patch.=0A=
=0A=
Leo, who can merge this patch and request a pull?=0A=
=0A=
York=0A=
