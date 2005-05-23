Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (exchange.tsi-telsys.com
	[205.230.130.11]) by ozlabs.org (Postfix) with ESMTP id 9A1C0679EF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 06:56:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 23 May 2005 16:56:31 -0400
Message-ID: <0007F077BB3476449151699150E8FEA21A7BA1@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: tah reset?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My intention is not to waste anybody's time and I think, I did not. As I =
mentioned to you earlier that I am working on the vendor provided =
version of Linux Kernel 2.4.27-pre3, which looks clearly from =
kernel.org. The value of PPC440GX_TAH0_ADDR and PPC440GX_TAH1_ADDR in =
arch/ppc/platforms/ibm440gx.h is 0x0000000140000b00 & 0x0000000140000d00 =
respectively. I verified this value in lk 2.4.30 also, these values are =
the same.

Though in lk 2.6.x, the values have been hardcoded in the =
arch/ppc/platforms/ibm440gx.c to 0x0000000140000b50 and =
0x0000000140000d50. Therefore, the confusion.

I hope this clears your misunderstanding. I did not see your suggestion =
for using your version of 2.4.x backported driver of ibm_emac. I could =
use it, if you send it again.

Thanks,
Sanjay

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net]
Sent: Monday, May 23, 2005 4:04 PM
To: Sanjay Bajaj
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: tah reset?


On Mon, May 23, 2005 at 03:17:26PM -0400, Sanjay Bajaj wrote:
> I did find the source of the reset tah issue. The physical address=20
> of TAH 0 and TAH 1 was ending in B00h and D00h respectively. But in=20
> the UM, it ends in B50 and D50. the file affected is ibm440gx.c in=20
> arch/ppc/platforms.

Linux 2.6 has correct values for TAH base address, 2.4 doesn't have=20
any support for TAH at all.

Where did you get this incorrect code?

You see, you should have used supported sources (2.6) or the one I=20
recommended to you (my 2.4 backport) but you have ignored this =20
suggestion and wasted your time and time of people on this mail list.

Please, next time if you use some stuff which isn't in kernel.org's=20
tree, direct you questions to the person who made those patches,=20
because we cannot help you as we don't have the source code you are=20
using.

--=20
Eugene
