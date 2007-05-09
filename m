Return-Path: <fenkes@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1EC7DDDEB
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 22:46:58 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l49Cksix138466
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 12:46:54 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l49CknBj3944652
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 14:46:54 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l49Ckcst012058
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 14:46:39 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 0/6] IB/ehca: Assorted patches
MIME-Version: 1.0
Date: Wed, 9 May 2007 14:46:23 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705091446.23783.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a set of patches containing various improvements and bugfixes for the
IBM eHCA InfiniBand driver, bumping the version number to SVNEHCA_0023. The
patches are, in detail:

#1 - Serialize hypervisor calls in ehca_register_mr()
#2 - correctly set GRH mask bit in ehca_modify_qp()
#3 - Fix AQP0/1 QP number
#4 - remove _irqsave where it's not needed;
     move an #ifdef to where it makes even better sense
#5 - beautify sysfs attribute code and fix compiler warnings
#6 - disable scaling code by default and bump version number

The patches are ready for inclusion into 2.6.22 and apply on top of Roland's
git tree (which has been pulled by Linus recently, so they should apply the=
re,
too).

Cheers,
  Joachim

=2D-=20
Joachim Fenkes =A0-- =A0eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH =A0-- =A0Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220 =A0-- =A071032 Boeblingen =A0-- =A0Germany
eMail: fenkes@de.ibm.com =A0-- =A0Phone: +49 7031 16 1239
