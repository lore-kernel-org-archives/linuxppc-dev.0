Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25FCFDDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 01:17:09 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n53FCswt008852
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Jun 2009 11:12:54 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n53FH6mA255672
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Jun 2009 11:17:06 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n53FEu9o028594
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Jun 2009 11:14:56 -0400
Received: from zod.rchland.ibm.com (sig-9-65-100-53.mts.ibm.com [9.65.100.53])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n53FEna2028184
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Jun 2009 11:14:55 -0400
Date: Wed, 3 Jun 2009 11:16:59 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] Convert more boards to ppc40x_simple
Message-ID: <20090603151659.GD8655@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Below are some patches to convert the Malaku and Kilauea/Halekala boards to the
ppc40x_simple platform.  I've tested the second patch on my Halekala board.
The Malaku patch should work as well, but I don't have access to one of those
boards.  Feedback would be appreciated.

josh
