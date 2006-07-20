Return-Path: <anne-sophie.harnois@thomson.net>
Received: from dmzraw4.extranet.thmulti.com (dmzraw4.extranet.thmulti.com
	[141.11.234.72]) by ozlabs.org (Postfix) with ESMTP id 4F2F767BAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 01:33:45 +1000 (EST)
Received: from boulvss1.eu.thmulti.com (unknown [141.11.234.35])
	by dmzraw4.extranet.thmulti.com (Postfix) with ESMTP id 80F5B1CF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 15:00:48 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by boulvss1.eu.thmulti.com (Postfix) with ESMTP id E057D136F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 15:00:00 +0000 (GMT)
Received: from boulvss1.eu.thmulti.com ([127.0.0.1])
	by localhost (indyvss4.am.thmulti.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 14784-01-96 for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 14:59:46 +0000 (GMT)
Received: from boulsmailbh01.eu.thmulti.com (boulsmailbh01.eu.thmulti.com
	[141.11.192.5])
	by boulvss1.eu.thmulti.com (Postfix) with ESMTP id D19B911F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 14:44:24 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: multicast for 8260 for 2.6.13
Date: Thu, 20 Jul 2006 16:45:11 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D5D2488@rennsmail02.eu.thmulti.com>
From: "Harnois Anne-Sophie" <anne-sophie.harnois@thomson.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello

In the file arch/ppc/8260_io/fcc_enet.c, set_multicast_list function is
commented out and I can't figure out why.=20
I checked the code, removed the comments and tried it, and multicast
seemed to work properly.=20

What am I missing?
Could someone explain me why this is commented out?

Many thanks,
Anne-Sophie
