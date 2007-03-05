Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30A5FDDF1D
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 00:57:48 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l25DvjdT027522
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 08:57:45 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l25Dvi77543520
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 06:57:44 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l25DviLj003503
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2007 06:57:44 -0700
Subject: Re: [0/15] Ebony support, spin 3
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070305032307.GB31417@localhost.localdomain>
References: <20070305032307.GB31417@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Mar 2007 07:57:41 -0600
Message-Id: <1173103061.6561.0.camel@zod.rchland.ibm.com>
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

On Mon, 2007-03-05 at 14:23 +1100, David Gibson wrote:
> Third version of the Ebony support patch series.  Notable changes:
> 	- Clock speeds, memory size and MAC addresses are now obtained
> from the hardware/firmware by the zImage and inserted into the device
> tree accordingly.  i.e. these patches should now work on any Ebony,
> not just one identical to mine.
> 	- The kernel can now restart the Ebony.

After including Ben's emac port, these patches boot to a prompt via NFS
rootfs on my board just fine.

josh
