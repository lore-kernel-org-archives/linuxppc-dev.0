From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Sanjay Kumar" <skumar@giga-stream.de>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Registering ATM devices.
Date: Fri, 13 Jun 2003 16:41:41 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJAEIODCAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <FKEJLMJFECLAHOKCGJFPMEOACAAA.skumar@giga-stream.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Sanjay,

I think it would be best to register one driver for each PHY otherwise you whount have any information what interface a new
connection is assigned to.
On the oher hand I am not shure if there is enough protection against parallel access of different device drivers running at the
same hardware...

Regards, Stephan

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Sanjay
> Kumar
> Sent: Freitag, 13. Juni 2003 08:39
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Registering ATM devices.
>
>
>
> Dear all,
>
> I have MPC8266 having connected two UTOPIA II interface on FCC1 and FCC2.
> UTOPIA II interface connected to FCC1 has 16 PHY devices connected to it
> and UTOPIA II interface connected to FCC2 has 2 PHY devices connected to
> it.
>                     while registering the atm devices via
> atm_device_register() function should I register two atm devices, one for
> each UTOPIA II interface conncetd to FCC1 and FCC2 or 18 atm devices for
> each PHY devices connected on both UTOPIA II interface.Total number of PHY
> devices on both UTOPIA II interface is 18.
>
> Any suggestion will be helpfull to me.
>
> with regards,
> sanjay
>
>  ==============================================================
>  Sanjay Kumar                        skumar@giga-stream.de
>  GIGA-STREAM UMTS Technologies GmbH  Tel: +49 (07243) 94976-119
>  Im Ermlisgrund 8                    Fax: +49 (07243) 94976-100
>  76337 Waldbronn
>  ==============================================================
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
