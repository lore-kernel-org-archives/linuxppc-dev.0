Return-Path: <SRS0=2/sND6=HW=cogcomp.com=mike@yourhostingaccount.com>
Received: from mailout10.yourhostingaccount.com
	(mailout10.yourhostingaccount.com [65.254.253.85])
	by ozlabs.org (Postfix) with ESMTP id 7B5B7DDEED
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 11:44:23 +1100 (EST)
Received: from mailscan03.yourhostingaccount.com ([10.1.15.3]
	helo=mailscan03.yourhostingaccount.com)
	by mailout10.yourhostingaccount.com with esmtp (Exim)
	id 1HH7rr-0007MF-SU
	for linuxppc-dev@ozlabs.org; Tue, 13 Feb 2007 19:19:27 -0500
Received: from authsmtp08.yourhostingaccount.com ([10.1.18.8] ident=exim)
	by mailscan03.yourhostingaccount.com with spamscanlookuphost (Exim)
	id 1HH7rr-0007CT-Mk
	for linuxppc-dev@ozlabs.org; Tue, 13 Feb 2007 19:19:27 -0500
Received: from authsmtp08.yourhostingaccount.com ([10.1.18.8]
	helo=authsmtp08.yourhostingaccount.com)
	by mailscan03.yourhostingaccount.com with esmtp (Exim)
	id 1HH7rr-0007CQ-2u
	for linuxppc-dev@ozlabs.org; Tue, 13 Feb 2007 19:19:27 -0500
Received: from ip68-9-156-117.ri.ri.cox.net ([68.9.156.117]
	helo=mike-home.cogcomp.com)
	by authsmtp08.yourhostingaccount.com with esmtpa (Exim)
	id 1HH7rq-0002lq-T8
	for linuxppc-dev@ozlabs.org; Tue, 13 Feb 2007 19:19:27 -0500
Message-Id: <6.2.5.6.2.20070213191530.03e27eb0@cogcomp.com>
Date: Tue, 13 Feb 2007 19:21:26 -0500
To: linuxppc-dev@ozlabs.org
From: Michael Kelly <mike@cogcomp.com>
Subject: USB Host controller for MPC8548e board
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: Michael Kelly <mike@cogcomp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all.  We are in the process of designing an MPC8548e board.  We 
wish to add
USB host via either the NXP ISP1561 or NEC upd720101.  They are both OHCI and
EHCI.

Is there any general advice on one over the other or even if it is 
realistic to have a USB
host controller on a big endian processor?

Regards,
Michael


Michael J. Kelly
VP Engineering
Cogent Computer Systems, Inc.
17 Industrial Dr.
Smithfield, RI 02917 USA
tel: 401-223-3441, fax: 401-223-3442
email: mike@cogcomp.com
alternate email: mkelly6505@hotmail.com
web: www.cogcomp.com
