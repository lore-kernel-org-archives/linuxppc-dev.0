Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B021DDE1D
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 12:46:51 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l912kb7t003688
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 22:46:37 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l912kb41421248
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 20:46:37 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l912kbRP024666
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 20:46:37 -0600
Subject: Re: [PATCHv2 0/4] Xilinx Virtex support for arch/powerpc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
References: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
Content-Type: text/plain
Date: Sun, 30 Sep 2007 21:46:15 -0500
Message-Id: <1191206775.10089.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-09-30 at 16:20 -0600, Grant Likely wrote:
> 2nd version of Xilinx Virtex patches.  I've addressed all the comments
> that I've received so far.  This series is just the arch/powerpc support
> code.  I'll send the device driver changes in a seperate series for
> each driver.

Overall looks pretty darn good.  You dropped the patch to add you as the
Xilinx maintainer.  Oversight?

Also, the support seems fairly generic but I don't see any ml300.dts or
ml4xx.dts files.  And the Kconfig files don't select WANT_DEVICE_TREE.
Are those patches coming later, or do these boards really not need a DTS
file?

josh
