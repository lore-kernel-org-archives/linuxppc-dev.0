Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 816D567B7C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 13:50:33 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k8L43HQa007709
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 21:03:17 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k8L3oSD9010346
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 22:50:30 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux on custom Xilinx board with PPC405 hangs on boot
Date: Thu, 21 Sep 2006 11:50:25 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263516BFD2@zch01exm21.fsl.freescale.net>
In-Reply-To: <20060920235716.GV29167@austin.ibm.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Linas Vepstas" <linas@austin.ibm.com>,
	"Peter N. Andreasen" <peterarbejde@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<snip>
> > Instruction machine check in kernel mode.
> > Oops: machine check, sig: 7
> > NIP: C00A2960 XER: 40000000 LR: C009CBD8 SP: C04D9D90 REGS:=20
> c04d9ce0 TRAP:
> > 0200    Not tainted
> > MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
>=20
> Machine checks happen when some hunk of hardware is wired to=20
> the machine-check pin of the cpu chip, and that bit of=20
> hardware decides to raise the wire.  I'd say the first step=20
> is to figure ou what hardware is wired up this way, and what=20
> would make it unhappy enough to assert a machine check.
>=20
> SRR1 has bits that state what caused he machine check. -- e.g=20
> partity error on data or address bus, "transfer error", or MC signal.

The PPC405 has different registers for machine check. Unlike classic
powerpc.

-Dave
