Return-Path: <Renaud.Barbier@ge.com>
Received: from ext-nj2gw-5.online-age.net (ext-nj2gw-5.online-age.net
	[64.14.56.41]) by ozlabs.org (Postfix) with ESMTP id E426F2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Dec 2004 04:44:34 +1100 (EST)
Received: from int-nj2gw-6.online-age.net (int-nj2gw-6 [3.159.236.70])
	by ext-nj2gw-5.online-age.net (8.12.9/8.12.9/990426-RLH) with ESMTP id
	iB3HiTav012985
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Dec 2004 12:44:30 -0500 (EST)
Received: from cinmlef07.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-nj2gw-6.online-age.net (8.12.9/8.12.8/990426-RLH) with ESMTP id
	iB3HiSFG023627
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Dec 2004 12:44:29 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 3 Dec 2004 11:45:25 -0600
Message-ID: <45ABD2373C33C4459D42B40EC4F346F20482F5DA@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: 440GX MMU problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

the memory test from U-boot does not complain as well as vxWorks.

I will do my own test anyway.

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net]
Sent: Friday, December 03, 2004 5:40 PM
To: Barbier, Renaud (GE Infrastructure)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 440GX MMU problem


On Fri, Dec 03, 2004 at 06:12:31AM -0600, Barbier, Renaud (GE =
Infrastructure) wrote:
>=20
> I am using linux 2.4.26 on a 440GX with 512MB of SDRAM.
> >From U-boot I can see the whole memory.
> If I boot Linux, unless I set the boot parameter mem=3D256M (or less).
> it will not boot. Linux does not seem to go further than the =
MMU_setup.
>=20
> Any idea why it cannot use 512MB?

Incorrect SDRAM setup? Try running at least simple memory tests.

--
Eugene
