Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s22.bay0.hotmail.com (bay0-omc2-s22.bay0.hotmail.com
	[65.54.246.158]) by ozlabs.org (Postfix) with ESMTP id B328CDDEB7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 07:04:23 +1000 (EST)
Message-ID: <BAY115-W5609334AE7FC568C37A5DB2120@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>, <kashiwagi@co-nss.co.jp>,
	<glenn.g.hart@us.westinghouse.com>
Subject: Re: Virtex 4 Avnet Mini-Module Networking.
Date: Tue, 19 Jun 2007 21:04:22 +0000
Content-Type: text/plain; charset="iso-8859-1"
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


Dear Glenn,
Dear Yoshio

I'm wondering where are the original developers of TEMAC driver these days,=
 I have not seen any posts from any of andrei nor grant in the recent weeks=
. may be they are involved in other projects.

checksum off loading can be used only with SGDMA, it can also remain disabl=
ed in this mode and the CPU will compute the CSUM itself.=20
Grant's kernel source tree is 2.6.21 and the latest release of EDK is 9.1SP=
2. these two make a good set of dev tools for building the needed systems.=
=20

as far as I know there are some bugs in the SP1 version of edk 9.1 which ma=
kes the ethernet link unstable. In our tests the systems implemented with E=
DK 9.1SP1 were not able to bring up the linux root file system on NFS corre=
ctly and we always encoutered "segmentation fault" messages even when we li=
mited the packet sizes with rsize and wsize kernel parameters.

Using EDK 9.1SP2 however ( and also the latest virtex-dev tree from grant's=
 git tree ) we were able to bring up the root file system via NFS with exac=
tly no problem over both of 100mbits and 1000mbits links.

However unfortunately our band width tests for the gigabit ethernet link of=
 ML403 has not resulted any good values till now ( all of the obtained valu=
es are smaller than 40mbits/s for both of 100 and 1000 links ) we have not =
understood the reason for this behavior yet.

any how, the main disscussion is about avnet mini module and availability o=
f good examples and good base systems for it.=20
Basically the main question can be stated as follows:
- Is there any reference design, or example available for avnet mini-module=
.?=20

---------------------------------------------------------------------------=
-----
>Message: 9
>Date: Tue, 19 Jun 2007 14:06:18 -0400
>From: Glenn.G.Hart@us.westinghouse.com
>Subject: Re: Virtex 4 Avnet Mini-Module Networking.
>To: kashiwagi@co-nss.co.jp,	linuxppc-embedded@ozlabs.org
>Message-ID:
>=09
>Content-Type: text/plain; charset=3D"us-ascii"
>=20
>=20
>Yoshio Kashiwagi,
>=20
>Yes the checksum off loading is turned off.  Should it be turned on?  My
>documentation says I need to use DMA mode to use checksum offloading.
>=20
>Glenn

_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=
