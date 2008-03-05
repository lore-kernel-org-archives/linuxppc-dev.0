Return-Path: <carcadiz@hotmail.com>
Received: from blu139-omc3-s10.blu139.hotmail.com
	(blu139-omc3-s10.blu139.hotmail.com [65.55.175.210])
	by ozlabs.org (Postfix) with ESMTP id 43D3ADDF0B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 21:09:01 +1100 (EST)
Message-ID: <BLU106-W11BB87023EFF6EED3D8E4DCA110@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: I2S driver
Date: Wed, 5 Mar 2008 11:09:00 +0100
In-Reply-To: <538035.10329.qm@web23104.mail.ird.yahoo.com>
References: <BLU106-W3340DC3BF1A9FD27E9FCD3CA100@phx.gbl>
	<538035.10329.qm@web23104.mail.ird.yahoo.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Angelo wrote:

> Thanks for code.
> But why i can't see library?

Which library do you mean? I don't understand, sorry.
=20
>>After the module I send you also the code from another module that>establ=
ishes PSC as I2S configuration. Clocks where adjusted to send>the audio dat=
a also at 44.1 Khz as fine tunned as possible due to>communication requirem=
ents of the attached DAC in that hardware.
> You'll send me another code?

This code was already in my previous email. After "------------------------=
-------------------" at the end of the email. Check it again, hehehe.

> And what about my file lite5200b.dts?
> I must enable some like this?
>         // PSC3 in CODEC mode example
>         //i2s@2400 {        // PSC3
>         //    device_type =3D "sound";
>         //    compatible =3D "mpc5200b-psc-i2s";//not 5200 compatible
>         //    cell-index =3D ;
>         //    reg =3D ;
>         //    interrupts =3D ;
>         //    interrupt-parent =3D <&mpc5200_pic>;
>         //};

I didn't need it. :-)

>=20
> ________________________________
> L'email della prossima generazione? Puoi averla con la Nuova Yahoo! Mail

_________________________________________________________________
Tecnolog=EDa, moda, motor, viajes,=85suscr=EDbete a nuestros boletines para=
 estar siempre a la =FAltima
http://newsletters.msn.com/hm/maintenanceeses.asp?L=3DES&C=3DES&P=3DWCMaint=
enance&Brand=3DWL&RU=3Dhttp%3a%2f%2fmail.live.com=
