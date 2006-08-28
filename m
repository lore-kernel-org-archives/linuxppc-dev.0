Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C49BE67B57
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 17:07:50 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7S8Qiii007593 for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 02:26:44 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7S77k5p012379
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 02:07:48 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Cache coherency question
Date: Mon, 28 Aug 2006 15:08:17 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC602@zch01exm20.fsl.freescale.net>
In-Reply-To: <995B09A8299C2C44B59866F6391D263511B930@zch01exm21.fsl.freescale.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>,
	"Martin, Tim" <tim.martin@viasat.com>, "ppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Liu Dave-r63238
> Sent: Monday, August 28, 2006 3:00 PM
> To: Li Yang-r58472; 'Martin, Tim'; 'ppc'
> Subject: RE: Cache coherency question
>=20
> <snip>
> > Looking from source code, there is such problem for MV64360.
> > It's likely that MV54360 has the same problem.
>=20
> What is the MV54360?

>From document at
http://www.motorola.com/mot/doc/5/5503_MotDoc.pdf#search=3D%22MV54360%22
The board uses MV54360.

I don't know if it is a typo or new variant though.
>=20
> -Dave
