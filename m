Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBBAFDDF3C
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:32:47 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9C7D27C7-674E-44B7-A975-69B2E85AB8F2@kernel.crashing.org>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
	<9C7D27C7-674E-44B7-A975-69B2E85AB8F2@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 May 2007 07:32:33 +1000
Message-Id: <1180474353.19517.190.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 08:10 -0500, Kumar Gala wrote:
> This is all problematic since some 64-bit implementations may not  
> guarantee the upper bits are valid when in 32-bit mode.  Look at the  
> 'Computation Modes' section in the architecture specs 2.03 or
> greater  
> for embedded processors. 

Yuck. Well, we might need to export a spearate CPU feature bit to
indicate that it's the case then.

Ben.
