Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F56ADE0C2
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 17:09:10 +1100 (EST)
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1mz42mllk.fsf@ebiederm.dsl.xmission.com>
References: <m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
	<20070128.155155.51857352.davem@davemloft.net>
	<1170032301.26655.140.camel@localhost.localdomain>
	<20070128.171309.11624572.davem@davemloft.net>
	<m1mz42mllk.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 17:08:46 +1100
Message-Id: <1170050926.26655.236.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: greg@kroah.com, kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> My problem is that I have been asking about RTAS for six months
> since before OLS.  Slowly the information has trickled in.  My first
> impression is boy is that weird.  My second impression after getting
> the full details was huh?  That is ridiculous, simply because they
> don't need to do a 

Michael's been posting early versions of his work ages ago, as Jake did
with some of his earlier stuff based on hooking at the toplevel, and I'm
pretty sure that at least for Michael's stuff, you've always been CCed.

Anyway, doesn't matter now. In my latest reply to David, I've basically
summarized what I think are our 2 options to move forward based on your
patches, I would appreciate your input on that.

Ben.
