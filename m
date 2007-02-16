Return-Path: <benh@kernel.crashing.org>
Subject: Re: purpose of /chosen node (was RE: [PATCH] powerpc: delete
	boot-cpu and chosen nodes from all DTSfiles)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070215230134.GB21654@localhost.localdomain>
References: <c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
	<20070215230134.GB21654@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 16 Feb 2007 11:08:39 +1100
Message-Id: <1171584519.5644.60.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You're right.  Question is, can we change it now.  It's out there in
> the documentation, on the other hand, I don't think the kernel
> actually uses it anywhere yet.  BenH, opinion?

We can change the documentation and add a little note about "obsoleted
practice". I don't think the kernel uses it.

Ben.
