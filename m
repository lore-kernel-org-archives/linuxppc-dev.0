Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D792DDEF1
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:03:05 +1000 (EST)
Subject: Re: [RFC/PATCH 2/5] powerpc: Cleanup ptrace bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070529064531.D874CDDF70@ozlabs.org>
References: <20070529064531.D874CDDF70@ozlabs.org>
Content-Type: text/plain
Date: Tue, 29 May 2007 19:02:50 +1000
Message-Id: <1180429370.19517.142.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ulrich.weigand@de.ibm.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 16:45 +1000, Benjamin Herrenschmidt wrote:
> 
> This patch cleans that up a bit by having a ptrace-common.h which
> contains
> really common code (and makes a lot more code common), and
> ptrace-ppc32.h and
> ptrace-ppc64.h files that contain the few remaining different bits. 

Hrm.. we do have a subtle difference in vrregs that I've missed.. I'll
respin tomorrow. It looks like we don't store the VRSAVE register at the
same place on 32 and 64 bits... yuck. I need to double check tomorrow.

Ben.
