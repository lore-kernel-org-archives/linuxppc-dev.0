Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 8666267B3D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 09:56:18 +1000 (EST)
Message-ID: <4254771B.2070802@nortel.com>
Date: Wed, 06 Apr 2005 17:56:11 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <425429BF.1050706@nortel.com> <1112829596.9518.210.camel@gaston>	
	<42547112.9000302@nortel.com> <1112831363.9518.215.camel@gaston>
In-Reply-To: <1112831363.9518.215.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: question on inline assembly and long long values
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> But the kernel code always runs in 64 bits mode...

The ppc kernel (not ppc64) runs in 64-bit mode?  An unsigned long long 
fits in a single register in C code?

Yeah, the optimisations really don't matter much...the ugly resulting 
code just bothered me.

Chris
