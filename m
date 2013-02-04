Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E65D2C02B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 03:34:25 +1100 (EST)
Date: Mon, 4 Feb 2013 10:34:12 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/1] powerpc/85xx: Board support for ppa8548
To: Timur Tabi <timur.tabi@calxeda.com>
References: <1359733013-722-1-git-send-email-stef.van.os@prodrive.nl>
 <1359765063.23561.14@snotra>
 <CAOZdJXU6OFu1878s9rrNws3uqT_F7-GFS95ZJT5EZmw35=6hbQ@mail.gmail.com>
In-Reply-To: <CAOZdJXU6OFu1878s9rrNws3uqT_F7-GFS95ZJT5EZmw35=6hbQ@mail.gmail.com>
 (from timur.tabi@calxeda.com on Fri Feb  1 22:34:44 2013)
Message-ID: <1359995652.14901.0@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Stef van Os <stef.van.os@prodrive.nl>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/01/2013 10:34:44 PM, Timur Tabi wrote:
> On Fri, Feb 1, 2013 at 6:31 PM, Scott Wood <scottwood@freescale.com> =20
> wrote:
> >
> > I guess the reason you're not using fsl/mpc8548si-post.dtsi is that =20
> you
> > don't want PCI.  Maybe PCI and srio should be moved out of that =20
> file, or
> > ifdeffed if 85xx ever ends up using the preprocessor for its device =20
> trees.
>=20
> Wouldn't it be easier to add status=3D"disabled" in this dts file?  I do
> something similar with the LBC on the p1022rdk.
>=20
> 	board_lbc: lbc: localbus@ffe05000 {
> 		/* The P1022 RDK does not have any localbus devices */
> 		status =3D "disabled";
> 	};

Yeah, that'd work.

-Scott=
