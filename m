Return-Path: <BlakesleeS@embeddedplanet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 2 Nov 2005 09:31:53 -0500
Message-ID: <1628E43D99629C46988BE46087A3FBB93AE139@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "KylongMu" <mqy@263.net.cn>,
	"Wolfgang Denk" <wd@denx.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: RE: About 2.6.14 on AMCC Yosemite board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Your FLASH mapping says that FLASH starts at 0xFC000000.  There should
only be 32Meg of FLASH starting at address 0xFE000000.=20

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of KylongMu
> Sent: Wednesday, November 02, 2005 8:50 AM
> To: 'Wolfgang Denk'
> Cc: Linuxppc-embedded@ozlabs.org
> Subject: About 2.6.14 on AMCC Yosemite board
>=20
> Hi, Denk
> 	I've got my Yosemite board today, it's shows very good=20
> by default test.
> I downloaded the 2.6.14 according the repository from your=20
> website by cogito.
> with default configure, I boot with the uImage, but the=20
> system halt, attachment is the message.
> 	I don't know what happen with it, pls help me.
>=20
> Thanks a lot!
>=20
> Kylong Mu
>=20
