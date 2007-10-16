Return-Path: <fenkes@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10FACDDEA0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 01:22:38 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l9GFMYs5242180
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 15:22:34 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l9GFMXRn2228408
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 17:22:33 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l9GFMXit026134
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 17:22:33 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 0/5] IB/ehca: SRQ and MR/MW fixes
MIME-Version: 1.0
Date: Tue, 16 Oct 2007 17:22:28 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710161722.29144.fenkes@de.ibm.com>
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

Here are some more fixes for the eHCA driver, fixing some problems we found
during internal system test.

[1/5] fixes the QP pointer determination for SRQ base QPs
[2/5] fixes a masking error in {,re}reg_phys_mr()
[3/5] fixes a bug in alloc_fmr() and simplifies some code
[4/5] refactors hca_cap_mr_pgsize and fixes a problem with ib_srp
[5/5] enables large page MRs by default

I built the patches on top of Roland's for-2.6.24 git branch. Please review
and queue them for 2.6.24-rc1 if you're okay with them. Thanks!

Cheers,
  Joachim

=2D-=20
Joachim Fenkes =A0-- =A0eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH =A0-- =A0Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220 =A0-- =A071032 Boeblingen =A0-- =A0Germany
eMail: fenkes@de.ibm.com
