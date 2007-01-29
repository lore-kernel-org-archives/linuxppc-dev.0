Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5704DDE0A
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 11:58:46 +1100 (EST)
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070128.155155.51857352.davem@davemloft.net>
References: <m1lkjmok2j.fsf@ebiederm.dsl.xmission.com>
	<1170026259.26655.114.camel@localhost.localdomain>
	<m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
	<20070128.155155.51857352.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 11:58:21 +1100
Message-Id: <1170032301.26655.140.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: greg@kroah.com, kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> There are specific calls into the sparc64 hypervisor for MSI vs. MSI-X
> configuration operations.  So a type is necessary.

BTW. Do you have some pointers to documentation on those sparc64
interfaces ? I'd like to have a look as we might still try to change
some of our approach to match some of Eric's whishes, I want to make
sure I'm not going somewhere that will not work for sparc...

For example, I'd like to know if sparc64 HV is indeed like IBM, that is
a single HV call does the complete setup, or if you still have some
level of manual config space access to do.

Ben.
