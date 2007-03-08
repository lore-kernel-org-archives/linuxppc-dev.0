Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4AACBDDE3E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 18:12:09 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l287C5bA014049
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 00:12:05 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l287C3H1026959
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 01:12:04 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][5/5] powerpc V2: Add the general support for
	EmbeddedFloating-Point instructions
Date: Thu, 8 Mar 2007 15:12:02 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E92B1ED@zch01exm20.fsl.freescale.net>
In-Reply-To: <AF8088A8-D4D1-4C4E-A9A7-16944C048145@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: linuxppc-dev-bounces+ebony.zhu=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+ebony.zhu=3Dfreescale.com@ozlabs.or
> g] On Behalf Of Kumar Gala
> Sent: Friday, February 23, 2007 2:23 AM
> To: Sergei Shtylyov
> Cc: linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [patch][5/5] powerpc V2: Add the general support=20
> for EmbeddedFloating-Point instructions
>=20
>=20
> On Feb 22, 2007, at 10:56 AM, Sergei Shtylyov wrote:
>=20
> > Hello.
> >
> > Segher Boessenkool wrote:
> >>>>>  arch/powerpc/sysdev/sigfpe_handler.c |  361
> >>>>> ++++++++++++++++++++++++++++++++++
> >
> >>>>    I'm sorry, but is sysdev/ really fitting place for this file?
> >>>> Shouldn't it be under kernel/ or math-emu/ instead?
> >
> >>>     Also, the name doesn't look fittingto me, since we're not=20
> >>> handling
> >>> *SIGFPE* here (which is for userland), we're handling SPE=20
> >>> exceptions.
> >
> >> arch/powerpc/math-emu/spe/<whatever>.c seems like a good place?
> >
> >     Yeah, certainly more like it. :-)
> >
> >> Segher
>=20
> Agreed, this shouldn't have been in sysdev, didn't notice that :)
>=20
> We should probably rename this as well, since its not just=20
> handling the sigfpe part, but the actual fixup/emulation.
>=20
> - k

Hi All,

Base on your suggestion, how about move sigfpe_handler.c to
arch/powerpc/math-emu/spe/spe_handler.c? Or do you have any other
suggestions on file name?

B.R.
Ebony
