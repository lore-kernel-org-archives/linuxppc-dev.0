Return-Path: <fenkes@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5EA8DDDE6
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 00:32:55 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id lA2DWp1L060038
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 13:32:51 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id lA2DWp2V2310332
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 14:32:51 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lA2DWoPN018228
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 14:32:51 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 0/2] IB/ehca: Return physical link information,
	fix static rate calculation
MIME-Version: 1.0
Date: Fri, 2 Nov 2007 15:32:49 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711021432.50203.fenkes@de.ibm.com>
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

This patchset will fix static rate calculation for the new link speeds
supported by eHCA2. Also, it enables query_port() to return physical link
information instead of constant values, which is needed for the static rate
fix.

[1/2] makes query_port() return actual physical link info where supported
[2/2] fixes static rate calculation based on that info

The patches will apply, in order, on top of Roland's for-2.6.24 branch.
Please review them and apply for 2.6.24-rc2 if you think they're okay.

Thanks and regards,
  Joachim

-- 
Joachim Fenkes  --  eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH  --  Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220  --  71032 Boeblingen  --  Germany
eMail: fenkes@de.ibm.com
