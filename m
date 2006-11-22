Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 300A767C56
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 08:36:50 +1100 (EST)
Subject: Re: Incorrect order of last two arguments of ptrace for requests
	PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1164220580.12365.8.camel@hades.cambridge.redhat.com>
References: <453F421A.6070507@in.ibm.com>
	<1164220580.12365.8.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 08:35:43 +1100
Message-Id: <1164231343.5653.30.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	supriya kannery <supriyak@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-22 at 18:36 +0000, David Woodhouse wrote:
> On
> > This is because PPC_PTRACE_GETREGS option for powerpc is implemented 
> > such that general purpose
> > registers of the child process get copied to the address variable 
> > instead of data variable. Same is
> > the case with other PPC request options PPC_PTRACE_SETREGS, GETFPREGS 
> > and SETFPREGS.
> > 
> > Prepared a patch for this problem and tested with 2.6.18-rc6 kernel. 
> > This patch can be applied directly to 2.6.19-rc3 kernel.
> 
> A more appropriate place to send this would be the linux-ppc development
> list.

Also it's possible that existing code like gcc relies on that "feature"
no ?

Ben.
 
