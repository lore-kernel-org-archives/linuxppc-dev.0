Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 7ABF4DDE2E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 19:08:18 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l1888Bbf007878
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 01:08:11 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l18889tB028696
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 02:08:10 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][0/5] powerpc V2 : Add support to fully comply with
	IEEE-754 standard
Date: Thu, 8 Feb 2007 16:08:07 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8B7E7E@zch01exm20.fsl.freescale.net>
In-Reply-To: <57721FE9-D85E-4FB6-AD5F-8342D99E7BD0@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >>
> >> Did you end up getting testfloat running?  I'd like to see some=20
> >> testing results before accepting these patches.  I think=20
> testfloat is=20
> >> our best bet at this point.
> >>
> > Hi Kumar,
> >
> > I looked into the testfloat suit, and found all the instructions it=20
> > tests (more than 50)should be implemented based on ASM.
>=20
> Don't follow?  Can't you build it with the e500 compiler?
>=20
The TestFloat suite provided the target of 386-Win32-gcc and
SPARC-Solaris-gcc only, and a template for user to porting his
own processor. Some general instructions are implemented in C,
but some CPU specific instructions like evfsmul need to be
implemented assemblely. To build it with e500 compiler we still
Have some porting work to do.

B.R.
Ebony
