Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 139B1DDF33
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 02:26:54 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1EFQmho016732
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 10:26:48 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1EFQkDP634166
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 10:26:46 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1EFQjHE011407
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 10:26:46 -0500
Date: Thu, 14 Feb 2008 09:25:23 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] remove unused CONFIG_WANT_DEVICE_TREE
Message-ID: <20080214092523.407d3ddd@zod.rchland.ibm.com>
In-Reply-To: <20080214041301.30383.5581.stgit@trillian.secretlab.ca>
References: <20080214041301.30383.5581.stgit@trillian.secretlab.ca>
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

On Wed, 13 Feb 2008 21:14:09 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
> 
> CONFIG_DEVICE_TREE was the only user of CONFIG_WANT_DEVICE_TREE but
> it was removed in commit id 25431333813686654907ab987fb5de10c10a16db
> (bootwrapper: Build multiple cuImages).
> 
> This patch removes CONFIG_WANT_DEVICE_TREE from Kconfig and the defconfigs
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Tested on Ebony for 4xx.  Seems Paul already has it queued up.

I have some other changes coming and I'll update the defconfigs for 4xx
to remove reference to it.

josh
