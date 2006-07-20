Return-Path: <Tony.Li@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id DC498679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 22:07:56 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k6KDPXlv029143 for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 07:25:33 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k6KC7qTd010245
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 07:07:54 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Linux-ATM-General] mpc8360sar
Date: Thu, 20 Jul 2006 20:07:51 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635058751@zch01exm21.fsl.freescale.net>
In-Reply-To: <44BF5D6D.1070400@cambridgebroadband.com>
From: "Li Tony-r64360" <Tony.Li@freescale.com>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>,
	<linuxppc-embedded@ozlabs.org>, <linux-atm-general@lists.sourceforge.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, alex
I am tony li.  I am glad to know that you add many features support.
Do you have test the UBR and AAL0 ? I am lack of enviroment test them
now.
I have not read your code detailly.:)
And which ltib release version is your base ? I have updated my code a
little which contain a workaround for a bug.

Tony.li =20

-----Original Message-----
From: linux-atm-general-bounces@lists.sourceforge.net
[mailto:linux-atm-general-bounces@lists.sourceforge.net] On Behalf Of
Alex Zeffertt
Sent: Thursday, July 20, 2006 6:40 PM
To: linuxppc-embedded@ozlabs.org;
linux-atm-general@lists.sourceforge.net
Subject: [Linux-ATM-General] mpc8360sar

Hi lists,

I'm writing to announce a new project http://mpc8360sar.sourceforge.net
.
This is an ATM driver for the QUICC Engine (QE) of the PowerQUICC II Pro
range of processors.  It is based on Tony Li's fsl-atm driver and my
mpc8260sar driver.  I've basically used Tony's driver for the most low
level stuff and ported a lot of extra functionality from my PQII driver.

You will need the Linux BSP from Freescale to build this driver.

I have only tested this driver on mpc832xe-mds, but it should also work
on the mpc8360e-pb board.

If you use mpc8360sar, please let me know how you get on.  In particular
let me know if you work out how to stop the QE occaisionally corrupting
the TCT when using external channels.

Regards,

Alex

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT Join
SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDE
V
_______________________________________________
Linux-atm-general mailing list
Linux-atm-general@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-atm-general
