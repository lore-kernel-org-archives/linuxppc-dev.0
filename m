Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DEECDDDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 01:45:33 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6CFjSHw411756
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 15:45:28 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6CFjSdo2072612
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 17:45:28 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6CFjRkP000898
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 17:45:28 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 00/10] IB/ehca: Multiple Event Queues, MR/MW rework,
	large page MRs, fixes
MIME-Version: 1.0
Date: Thu, 12 Jul 2007 17:45:26 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707121745.27592.fenkes@de.ibm.com>
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

Building on top of the last patch series, this set of patches adds multi-EQ
support, fixes a few nits (including formatting), refactors the MR/MW code
and adds support for large page MRs. Another patch set will follow.

Note that patch 7 will introduce a few lines over 80 chars that will be
unindented in patch 8 - I hope that's okay with you.

The patches, in detail, are:

[01/10] adds support for multiple event queues (ie interrupt sources)
[02/10] fixes a problem with HW autodetection
[03/10] \
[04/10] |
[05/10] | These refactor and clean up the MR/MW code. We split them into
[06/10] | bite-sized chunks for easier review of the changes.
[07/10] |=20
[08/10] /=20
[09/10] fixes a lot of checkpatch.pl warnings
[10/10] adds large page MR support for eHCA2

The patches should apply cleanly, in order, against Roland's git. Please
review the changes and apply the patches if they are okay.

Regards,
  Joachim

=2D-=20
Joachim Fenkes =A0-- =A0eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH =A0-- =A0Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220 =A0-- =A071032 Boeblingen =A0-- =A0Germany
eMail: fenkes@de.ibm.com
