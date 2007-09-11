Return-Path: <fenkes@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 344E0DDEA2
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 23:19:04 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l8BDJ0Ok195976
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 13:19:00 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8BDIxsM2908290
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 14:18:59 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8BDIgxC029502
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 14:18:43 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 00/12] IB/ehca: New features and fixes for 2.6.24
MIME-Version: 1.0
Date: Tue, 11 Sep 2007 15:18:25 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709111518.26276.fenkes@de.ibm.com>
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

Here are some fresh eHCA driver features and fixes for your reviewing
pleasure. They have passed internal testing and checkpatch.pl, so we think
they are ready for inclusion.

[01/12] adds userspace support for small QPs
[02/12] changes a nit in firmware communication
[03/12] adds support for more than 4096 QPs/CQs in user space
[04/12] enables mapping firmware contexts into uspace on 64K-page kernels
[05/12] changes hvCall debug trace formatting
[06/12] outputs return codes as signed decimal integers
[07/12] makes warnings also appear in non-debug mode, like they should
[08/12] replaces get_paca()->paca_index by the portable smp_processor_id()
[09/12] checks the allowed max number of SGEs when creating a QP
[10/12] fixes some Path Migration problems
[11/12] works around a firmware race condition
[12/12] bumps the driver's version number

The patches should apply cleanly, in order, against Roland's git. Please
review the changes and apply the patches for 2.6.24 if they are okay.

Regards,
  Joachim

=2D-=20
Joachim Fenkes =A0-- =A0eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH =A0-- =A0Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220 =A0-- =A071032 Boeblingen =A0-- =A0Germany
eMail: fenkes@de.ibm.com
