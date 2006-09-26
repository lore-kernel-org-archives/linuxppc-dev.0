Return-Path: <jdub@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3029267B6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 01:23:51 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8QFNmU8000734
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Sep 2006 11:23:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8QFNl0T320362
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Sep 2006 09:23:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8QFNcSo030238
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Sep 2006 09:23:38 -0600
Received: from zod.rchland.ibm.com (zod.rchland.ibm.com [9.10.86.225])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k8QFNcCx030161
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Sep 2006 09:23:38 -0600
Subject: TFTP timeouts with EmbeddedPlanet 405 board
From: Josh Boyer <jdub@us.ibm.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 26 Sep 2006 10:26:30 -0500
Message-Id: <1159284390.31597.14.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I've recently inherited an EmbeddedPlanet 405 Iceplanet eval board and
I'm having trouble getting the bootloader to tftp a kernel.  Basically,
pings work, the file appears to be getting correctly served, however the
tftp transfer always times out.

Has anyone else seen this?

josh
