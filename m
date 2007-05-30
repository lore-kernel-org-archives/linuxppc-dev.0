Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3786DDFC6
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:56:32 +1000 (EST)
Subject: Re: [RFC/PATCH 2/4] powerpc: ptrace can set DABR on both 32 and 64
	bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AB7DD12D-76D5-43D8-90BF-904C7C85205E@kernel.crashing.org>
References: <20070530080526.36115DDFC8@ozlabs.org>
	<AB7DD12D-76D5-43D8-90BF-904C7C85205E@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 May 2007 22:56:22 +1000
Message-Id: <1180529782.19517.279.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, ulrich.weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 07:44 -0500, Kumar Gala wrote:
> On May 30, 2007, at 3:05 AM, Benjamin Herrenschmidt wrote:
> 
> > Allow ptrace to set dabr in the thread structure for both 32 and 64  
> > bits,
> > though only 64 bits actually uses that field, it's actually defined  
> > in both.
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Can you make these -EIO for CONFIG_BOOKE for now.

I suppose best is to define set_dabr to have a result code...

The std DABR format is good enough to carry a generic setting whatever
the HW implementation is I think.

Ben.
