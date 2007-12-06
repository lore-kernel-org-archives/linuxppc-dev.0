Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0705FDE00E
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 06:49:24 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB6Jp2PU018763
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 14:51:02 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB6JnDAV1302626
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 14:49:13 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB6JnCmq009790
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 12:49:12 -0700
Date: Thu, 6 Dec 2007 13:46:20 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [PPC] virtex bug fix: Use canonical value for AC97
	interrupt xparams
Message-ID: <20071206134620.6e089ec3@zod.rchland.ibm.com>
In-Reply-To: <20071206191602.29192.42800.stgit@trillian.secretlab.ca>
References: <20071206191602.29192.42800.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 06 Dec 2007 12:16:44 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
> 
> The ml300 and ml403 xparameters.h files use different macros for the AC97
> interrupt pin assignments.  This patch normalizes them to a canonical
> value similar to what EDK generates for most other devices
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Paul, can you just grab this one?  I don't have any other fixes for .24
queued at the moment.

josh
