Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5221D67B88
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 11:08:31 +1000 (EST)
Subject: Re: [PATCH] kdump : Support kernels having 64k page size.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
In-Reply-To: <4500C0BA.8060408@in.ibm.com>
References: <44FE15B0.3030909@in.ibm.com>
	<1157511577.3661.7.camel@localhost.localdomain>
	<44FE6700.8080504@us.ibm.com>
	<1157590304.22705.267.camel@localhost.localdomain>
	<4500C0BA.8060408@in.ibm.com>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 11:08:07 +1000
Message-Id: <1157677687.22705.364.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-09-08 at 06:30 +0530, Sachin P. Sant wrote:
> > You should always do 64k regardless of the page size. I think we have
> > some ABI requirements here for ELF sections to be 64k aligned anyway
> > no ?
> >
> >   
> Ben are you aware of any doc where i can find more information. I 
> checked the
> 64Bit PowerPC ELF ABI doc but couldn't find any specific information about
> this.
> 
> Also other question is  If we create a 64k segment irrespective of page size
> [ as compared to 32k currently ] we would be writing extra 32k even for
> page size of 4K. Which means we have 32k less memory for the kdump
> kernel. Wouldn't that be an issue ?

32k sounds like a drop of water in the kdump pool ...

Ben.
