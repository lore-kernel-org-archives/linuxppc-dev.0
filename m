Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79D49DDED2
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 12:22:36 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5Q2MXh9021167
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 22:22:33 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5Q2MX5h256492
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 20:22:33 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5Q2MW0l024026
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 20:22:33 -0600
Date: Mon, 25 Jun 2007 21:33:06 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Remove redundant copy of the GPL
Message-ID: <20070626023305.GA11906@crusty.rchland.ibm.com>
References: <20070626014449.GD4383@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070626014449.GD4383@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2007 at 11:44:49AM +1000, David Gibson wrote:
> The dtc tree currently includes two copies of the GPL - one which was
> there originally, and one imported from the libfdt tree.  This patch
> gets rid of the extra copy in the libfdt tree.
> 
> In addition it renames the file containing the remaining copy from
> COPYING to GPL.  Since libfdt is dual-licensed, this seems clearer.

You might want to remove the mysterious reference to the LGPL in the
EXTRA_DIST variable in the Makefile while you're at it.

josh
