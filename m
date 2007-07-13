Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27286DDDF5
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 23:11:06 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6DDB3jF010064
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 09:11:03 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6DDB3lh262540
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 07:11:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6DDB2YB025163
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 07:11:03 -0600
Subject: Re: [PATCH] Update mpc7448hpc2 device tree to be compatible for
	tsi109 chip
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1184299081.30789.9.camel@localhost.localdomain>
References: <1184299081.30789.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Jul 2007 08:11:02 -0500
Message-Id: <1184332262.6456.7.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-07-13 at 11:58 +0800, Zang Roy-r61911 wrote:
> From: Roy Zang <tie-fei.zang@freescale.com>
> 
> Update mpc7448hpc2 device tree to be compatible for tsi109 chip.

Are there any actual changes in the drivers or platform files for
tsi109?  I seem to recall that Linux treated tsi108 and tsi109
identically at the moment.

If there are changes coming that differentiate tsi109 and tsi108, please
CC me on those so I can update the Holly board as well.

josh
