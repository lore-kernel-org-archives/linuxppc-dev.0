Return-Path: <Agostino.Sette@siemens.com>
Received: from MILVB94A.icn.siemens.it (milvb94a.icn.siemens.it
	[83.103.117.135]) by ozlabs.org (Postfix) with ESMTP id 61E7C686C3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 20:18:29 +1100 (EST)
Message-ID: <69DF49BE936F4441980EC1D59F0ADC2F0108C29F@aqlby02a.siemens.it>
From: Sette Agostino <Agostino.Sette@siemens.com>
To: wd@denx.de,
	Sette Agostino <Agostino.Sette@siemens.com>
Date: Tue, 8 Nov 2005 10:18:05 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: PPCBoot 2.0.0 Errors 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang,

As I told you, I tried to produce the U-boot, but I am nont confident =
on the
version (1.0.0).
Could you suggest me the latest stale version I must get?

Thanks

Best Regards,
Agostino Sette


TechnoLabs
Department of Innovation Software3
S.S. 17 Localit=E0 Boschetto
67100 L' Aquila (Italy)
Tel: (+39)  0862 344.557
Fax: (+39)  0862 344.623
e-mail: Agostino.Sette@siemens.com =20
=20

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]=20
Sent: marted=EC 8 novembre 2005 10.09
To: Sette Agostino
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPCBoot 2.0.0 Errors=20

In message =
<69DF49BE936F4441980EC1D59F0ADC2F0108C267@aqlby02a.siemens.it>
you wrote:
>=20
> I agree with you concerning the PPCBoot. In fact in other boards we =
are
using U-Boot.
> We tried to use U-Boot for MPC859 but we had some problems we are =
trying
to
> solve.

You cannot solve  these  problems  by  downgrading  to  PPCBoot.  The
852/859/866  processors  are  definitelu *not* supported by PPCBoot -
the required changes of the clock handling were added much later. You
*must* use U-Boot.

> As far as you know to change the boot or the kernel on cards in field =
is
not
> so easy :-(

You mean you shipped boards to customers in  the  field  in  a  state
where you did not even decide for a final version of the boot loader?
Gosh...

> We found an unexpected beahviour regarding the Linux time tick.=20

...whichis probablky cause by using PPCBoot which does not understand
to deal with a 859.

> Another interesting point is that the same kernel works well on other
TQM8xx
> modules, but not fot TQM859.

U-Boot is running perfectly fine on the TQM859 - we have these boards
here in our virtual lab; they are tested on a regular base.

> I will try to introduce the U-Boot, but I am not confident it will =
solve
the
> problem, what do you think about it?

I can *guarantee* you that PPCBoot is definitely worse on your =
hardware.

> Last question, which is the appropriate mailing list?

u-boot-users

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Always leave room to add an explanation if it doesn't work out.
