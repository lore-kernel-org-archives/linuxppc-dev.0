Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF05CDDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:06:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7SK6a0n014103
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 16:06:36 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7SK5jKo428542
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 14:06:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7SK1DlT022859
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 14:01:13 -0600
Date: Tue, 28 Aug 2007 15:01:12 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Re: [PATCH 1/1] Fix bus probe on Bamboo board
Message-ID: <20070828150112.0c213908@weaponx.rchland.ibm.com>
In-Reply-To: <20070828125100.31b0ab98@weaponx.rchland.ibm.com>
References: <20070828125100.31b0ab98@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2007 12:51:00 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> Commit 804ace8881d21 changed the behavior of how compatible nodes are found.
> This highlighted a bug on the Bamboo board where it wasn't probing the bus
> specified in the DTS file.  We fix it by being explicit about which bus to
> probe.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Paul, this is 2.6.24 material.  You can either pick it up, or get it
from my git tree later.  I mostly sent it out now in case people were
using the bamboo patches already.

josh
