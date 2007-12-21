Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 88D2ADDE32
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 23:15:09 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBLCF503017118
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 07:15:05 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBLCF5X2167454
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 05:15:05 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBLCF4Ra028981
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 05:15:04 -0700
Date: Fri, 21 Dec 2007 06:09:21 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 18/21] [POWERPC] bamboo: remove bogus "ranges" property
	in EBC node
Message-ID: <20071221060921.4ae5bc20@zod.rchland.ibm.com>
In-Reply-To: <20071221043939.72A8BDDFCF@ozlabs.org>
References: <20071221043939.72A8BDDFCF@ozlabs.org>
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

On Fri, 21 Dec 2007 15:39:35 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This removes a bogus empty "ranges" property in the EBC device node
> of the Bamboo board device-tree.
> 
> The "ranges" property will be created by the boot wrapper, there is
> no need to have an empty property there, and that causes recent
> dtc to complain.

The wrapper doesn't do anything with EBC for bamboo because the EBC
stuff is a nightmare on this board.  The patch can stand, but I'll
fixup the comments in the changelog.

josh
