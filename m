Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id D41C2DDE37
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 10:04:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 37/61] cpm2: Rework 8272ads initialization,
	and eliminate init_fcc_ioports().
Date: Thu, 19 Jul 2007 02:04:44 +0200
References: <20070718013548.GI15238@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070718013548.GI15238@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707190204.44825.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 18 July 2007, Scott Wood wrote:
> +static struct cpm_pin mpc8272ads_pins[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0/* SCC1 */
> +=A0=A0=A0=A0=A0=A0=A0{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
> +=A0=A0=A0=A0=A0=A0=A0{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
> +
> +=A0=A0=A0=A0=A0=A0=A0/* SCC4 */
> +=A0=A0=A0=A0=A0=A0=A0{3, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
> +=A0=A0=A0=A0=A0=A0=A0{3, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
> +
> +=A0=A0=A0=A0=A0=A0=A0/* FCC1 */
> +=A0=A0=A0=A0=A0=A0=A0{0, 14, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
> +=A0=A0=A0=A0=A0=A0=A0{0, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
> +=A0=A0=A0=A0=A0=A0=A0{0, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
> +=A0=A0=A0=A0=A0=A0=A0{0, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},

I guess you considered moving such tables into the device tree at some poin=
t,
which doesn't seem that difficult at all to an ignorant reviewer like me.

What's the reasoning for putting it into the platform code after all?

	Arnd <><
