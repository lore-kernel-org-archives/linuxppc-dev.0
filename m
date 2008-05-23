Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76142DE4F5
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 03:52:35 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4NHqQVD008245
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 13:52:26 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4NHqQlh091956
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 11:52:26 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4NHqPfk009694
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 11:52:26 -0600
Date: Fri, 23 May 2008 12:47:27 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] 4xx: Fix 460GT support to (re-)enable the FPU
Message-ID: <20080523124727.628fa28b@zod.rchland.ibm.com>
In-Reply-To: <1211547896-4263-1-git-send-email-sr@denx.de>
References: <1211547896-4263-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 23 May 2008 15:04:56 +0200
Stefan Roese <sr@denx.de> wrote:

> Since AMCC now reports that the 460GT *has* an FPU, we should enable it
> (again). This patch basically reverts my patch
> acb0142bf01c0ebe18f09e37814451ee6a873e27 ([POWERPC] 4xx: Fix 460GT support
> to not enable FPU), which disabled the FPU upon AMCC request.
> 
> Sorry about the confusion here.

I should just be able to use git-revert on that commit then, right?

josh
