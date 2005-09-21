Return-Path: <BLandau@nds.com>
Received: from ILEX5.IL.NDS.COM (jeru1.ndsisrael.com [192.118.34.248])
	by ozlabs.org (Postfix) with ESMTP id 899B1682F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 20:21:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 21 Sep 2005 13:21:03 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78076297@ILEX5.IL.NDS.COM>
From: "Landau, Bracha" <BLandau@nds.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: using SCC4 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am using the MPC8272ADS with kernel 2.6.10. The kernel is configured to=
 support 4 CPM SCCs, of which 1 and 4 are connected on the board.
I created device files as follows:

mknod /dev/ttyCPM0 c 204 46
mknod /dev/ttyCPM1 c 204 47
mknod /dev/ttyCPM2 c 204 48
mknod /dev/ttyCPM3 c 204 49

If I boot the kernel using console=3DttyCPM3 I see that it uses SCC4. But=
 when I boot with console=3DttyCPM0 and write to the second port using a =
command like "echo hello > /dev/ttyCPM3" I don't see that anything is bei=
ng outputted to the second console.

What am I doing wrong?
=20
*************************************************************************=
**********
Information contained in this email message is intended only for use of t=
he individual or entity named above. If the reader of this message is not=
 the intended recipient, or the employee or agent responsible to deliver =
it to the intended recipient, you are hereby notified that any disseminat=
ion, distribution or copying of this communication is strictly prohibited=
=2E If you have received this communication in error, please immediately =
notify the postmaster@nds.com and destroy the original message.
*************************************************************************=
**********
