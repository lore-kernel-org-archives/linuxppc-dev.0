Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0069DE0AA
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:18:51 +1000 (EST)
In-Reply-To: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <40815D64-3AD7-49C6-9A58-C7848691D940@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 09:17:48 -0500
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Steve Munroe <sjmunroe@us.ibm.com>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 9:08 AM, Ulrich Weigand wrote:

>
> Steve Munroe <sjmunroe@us.ibm.com> wrote on 05/29/2007 04:00:42 PM:
>
> > Yes exactly why make an incompatible ABI change to the powerp32  
> ABI, when
> > you can just use the existing 64-bit ABI.
> >
> > Especially as you can only run what is proposed on 64-bit hardware!
> >
> > We don't need another ABI change to powerpc32 (still recovering  
> from the
> > -msecure-plt ABI change) and WE DONT NEED a 3rd ABI.
> >
> > ABI changes ripple everywhere (not just GCC/GLIBC) including all  
> debuggers
> > and performance tools. Believe me you really don't want this.
>
> Fully agreed.  This may have gotten lost in the discussion thread,  
> but what
> Ben originally proposed was *not* an ABI change, for exactly that  
> reason.
> We simply want to allow strictly local use of 64-bit registers for
> performance optimization purposes, while still fully complying with
> the 32-bit ABI.

But we can't do that any more since the architecture specifically  
allows for the 'upper bits' not to have valid data in them.

- k
