Return-Path: <kumar.gala@freescale.com>
Received: from motgate4.mot.com (motgate4.mot.com [144.189.100.102])
	by ozlabs.org (Postfix) with ESMTP id D51AE2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Dec 2004 19:14:47 +1100 (EST)
In-Reply-To: <200412020907.44778.g.jaeger@sysgo.com>
References: <200412020907.44778.g.jaeger@sysgo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <349C6BAC-443A-11D9-ADCD-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 2 Dec 2004 02:14:36 -0600
To: "Gerhard Jaeger" <g.jaeger@sysgo.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH][PPC32] Fix gianfar netdriver oops when using bootp...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fun with mailers.  Try this url:

http://tinyurl.com/6skww

- kumar

On Dec 2, 2004, at 2:07 AM, Gerhard Jaeger wrote:

> Hi,
>
> On Wednesday 01 December 2004 23:19, Kumar Gala wrote:
>  > There is some belief that the following patch should fix the issue:
>  >
> > http://linux.bkbits.net:8080/linux-2.5/cset@1.2249.2.2?=20
> nav=3Dindex.html|ChangeSet@-3d
>  >
> > I would be interested to know if this helps w/o your patch.
>
> I'd like to cross-check this, but are you sure, you're referencing the=20=

> correct
>  changeset? Currently I only got:
>  Error 500
>  Unable to find revision 1.2249.2.2
>
> Gerhard
>
> >
> > - kumar
>  >
> > On Dec 1, 2004, at 10:07 AM, Gerhard Jaeger wrote:
>  >
> > > Hi,
>  > >
>  > > this patch fixes an issue, that occurs on my MPC8541CDS, when=20
> trying to
>  > >=A0 use bootp to get the IP parameters. It seems, that the patch=20=

> only=A0
>  > > cures
>  > >=A0 the symptom but obviously not the cause ;)
>  > >
>  > > Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>
> > >
>  > > --- linux-2.6.10-rc2-mm4/drivers/net/gianfar.c.orig=A0=A0=A0=A0=20=

> 2004-11-15=A0
> > > 02:26:34.000000000 +0100
>  > >=A0 +++ linux-2.6.10-rc2-mm4/drivers/net/gianfar.c=A0 2004-12-01=A0
> > > 17:00:19.000000000 +0100
>  > >=A0 @@ -1477,6 +1477,9 @@ static void gfar_phy_change(void *data)
>  > >=A0 =A0=A0=A0=A0=A0=A0=A0 struct gfar_private *priv =3D =
netdev_priv(dev);
> > > =A0=A0=A0=A0=A0=A0=A0 int result =3D 0;
>  > >=A0 =A0
>  > >=A0 +=A0=A0=A0=A0=A0=A0 if( !priv->mii_info->phyinfo )
>  > >=A0 +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return;
>  > >=A0 +
>  > >=A0 =A0=A0=A0=A0=A0=A0=A0 /* Delay to give the PHY a chance to =
change the
>  > >=A0 =A0=A0=A0=A0=A0=A0=A0=A0 * register state */
> > >=A0 =A0=A0=A0=A0=A0=A0=A0 msleep(1);
>  >
> >
