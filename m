Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 825A6DE0D9
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:33:54 +1000 (EST)
Subject: Re: [RFC/PATCH 2/5] powerpc: Cleanup ptrace bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B1CC4B3D-D77E-4023-BE92-2A8405998E38@kernel.crashing.org>
References: <20070529064531.D874CDDF70@ozlabs.org>
	<B1CC4B3D-D77E-4023-BE92-2A8405998E38@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 May 2007 07:33:43 +1000
Message-Id: <1180474424.19517.193.camel@localhost.localdomain>
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

On Tue, 2007-05-29 at 08:23 -0500, Kumar Gala wrote:

> Do we do some different lazy save/restore on ppc64 than ppc32?  I'm  
> trying to understand why the comment isn't (or wasn't) valid for  
> ppc32 as well.

Not sure :-) The code did different things and I didn't want to change
everything at once in that patch. It's on my list to clarify and
possibly fix.

Ben.
