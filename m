Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 6A9152C008F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2013 20:32:56 +1000 (EST)
Message-ID: <1375698760.3852.152.camel@thor.local>
Subject: Re: therm_pm72 units, interface
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 05 Aug 2013 12:32:40 +0200
In-Reply-To: <1375694554.12557.40.camel@pasglop>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local> <1375447861.15999.1.camel@pasglop>
 <1375454871.3852.27.camel@thor.local>
 <20130802155818.GB29933@blackmetal.musicnaut.iki.fi>
 <1375462346.3852.42.camel@thor.local> <1375477360.15999.19.camel@pasglop>
 <1375693993.3852.143.camel@thor.local> <1375694554.12557.40.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ben Hutchings <ben@decadent.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-05 at 19:22 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-08-05 at 11:13 +0200, Michel D=C3=A4nzer wrote:
>=20
> > The version below builds, but the module still doesn't get loaded
> > automagically (unless I'm missing some command I need to run between
> > copying the new module to /lib/modules/$(uname -r)/ and rebooting?).
>=20
> depmod -a ?

I did that, sorry should have mentioned that.


> > @@ -468,5 +478,3 @@ static struct platform_driver i2c_powermac_driver
> > =3D
> > {
> >  };
> >=20
> >  module_platform_driver(i2c_powermac_driver);
> > -
> > -MODULE_ALIAS("platform:i2c-powermac");
>=20
> Maybe add the module alias back ? It shouldn't be necessary...

Doesn't help.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
