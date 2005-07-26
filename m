Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 3BDEB67C5A
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jul 2005 05:56:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 26 Jul 2005 14:44:48 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8593EE@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Leitner, Kip" <Kip.Leitner@ipc.com>,
	<linuxppc-dev@ozlabs.org>
Subject: RE: 8260 FCC Ethernet problem
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
> From: linuxppc-dev-bounces@ozlabs.org=20
> [mailto:linuxppc-dev-bounces@ozlabs.org] On Behalf Of Leitner, Kip
> Sent: Tuesday, July 26, 2005 14:15
> We are wondering if we apply your patch to 2.4.18 fcc_enet.c,=20
> will this fix our late collision problem, as 2.4.18=20
> fcc_enet.c has the uncorrected part of the code in our Linux=20
> distribution that your patch fixes.

Try and see.
I have some doubts, as this only fixes a problem in full duplex mode,
and you are running in half duplex.
