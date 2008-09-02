Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84B80DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 07:05:07 +1000 (EST)
Subject: Re: [PATCH] powerpc: Reserve syscall number 319
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080902120824.GB2218@yoda.jdub.homelinux.org>
References: <20080902054941.77DA3DDDF0@ozlabs.org>
	<20080902120824.GB2218@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 07:02:47 +1000
Message-Id: <1220389367.13010.143.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-02 at 08:08 -0400, Josh Boyer wrote:
> On Tue, Sep 02, 2008 at 03:48:45PM +1000, Benjamin Herrenschmidt wrote:
> >Some stuff I'm working on that isn't released yet needs
> >a syscall number but I can't say what it's for until I
> >get permission to release it :-)
> >
> >In the meantime, it would be nice if a number could be set
> >aside so the tools being developped to use that stuff don't
> >all need to be updated when things are eventually released.
> >
> >Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >---
> >
> >I wonder if I'll get hanged for that one :-)
> 
> Is it a powerpc-specific syscall?  If so... ew?

Yes :-)

Ben.
