Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 9B72F67B5D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 03:14:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: ppc -> powerpc porting
Date: Mon, 10 Jul 2006 12:14:24 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DE5E@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To make my life a little easier: Does anybody have a list of stuff to
watch out for/need to do when porting a board from ppc to powerpc?
The board uses a Freescale 8265 and runs under 2.6.17, using platfrom
device support for accessing fs_enet driver.
