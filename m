Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 02FABDDE22
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 20:57:53 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m39AvneQ020131
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 06:57:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m39Avncf298594
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 06:57:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m39AvnQs027799
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 06:57:49 -0400
Date: Wed, 9 Apr 2008 05:56:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 4xx defconfig reorg
Message-ID: <20080409055601.1c82afb2@zod.rchland.ibm.com>
In-Reply-To: <18428.24729.933714.665889@cargo.ozlabs.ibm.com>
References: <1207487181.6809.18.camel@vader.jdub.homelinux.org>
	<73BD1263-F09B-4E08-AA77-BEBD67D91C58@kernel.crashing.org>
	<1207709608.3996.0.camel@vader.jdub.homelinux.org>
	<18428.24729.933714.665889@cargo.ozlabs.ibm.com>
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

On Wed, 9 Apr 2008 16:22:17 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Josh Boyer writes:
> 
> > I've not heard any objections.  I'll be pushing my commit to my next
> > branch tomorrow morning.
> 
> I don't have any objections.  I wonder if Sam Ravnborg responded to
> Segher's patch to extend make help?

I haven't seen any commentary on that at all.  Sam is quite busy from
what I gather.

I'll try to poke at things today a bit and see if we can get an Ack
from him either way.

josh
