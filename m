Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B834DE34A
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 23:35:32 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m76DZRAN001474
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 09:35:27 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m76DZPVZ162932
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 07:35:26 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m76DZPUL011788
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 07:35:25 -0600
Date: Wed, 6 Aug 2008 09:35:22 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: dtc update for in-kernel version
Message-ID: <20080806093522.5e076fd6@zod.rchland.ibm.com>
In-Reply-To: <6606960D-022E-4B6E-AAB8-036839469820@kernel.crashing.org>
References: <1218026580.2328.69.camel@localhost.localdomain>
	<6606960D-022E-4B6E-AAB8-036839469820@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 6 Aug 2008 08:29:30 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Aug 6, 2008, at 7:43 AM, Josh Boyer wrote:
> 
> > So we asked about this a while ago and I haven't seen anything yet,  
> > but
> > is there going to be an update to the version of DTC that is in the
> > kernel tree?  1.2 is out now, would be a good idea to update soon.
> 
> is there any reason to update to 1.2 for 2.6.27?

Probably not at this point in the lifecycle.  We brought this up
before the merge window opened though, so I'm just wondering what the
general plan is.  Seems lots of fixes and such are getting put out, but
not pulled into the kernel.

josh
