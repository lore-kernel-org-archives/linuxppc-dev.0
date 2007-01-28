Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id DF1B5DE148
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:26:50 +1100 (EST)
Date: Sun, 28 Jan 2007 15:26:48 -0800 (PST)
Message-Id: <20070128.152648.75190891.davem@davemloft.net>
To: ebiederm@xmission.com
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <m1fy9uq3et.fsf@ebiederm.dsl.xmission.com>
References: <m14pqbsg2j.fsf@ebiederm.dsl.xmission.com>
	<1170015292.26655.6.camel@localhost.localdomain>
	<m1fy9uq3et.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, brice@myri.com,
	greg@kroah.com, shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 28 Jan 2007 13:53:14 -0700

> The argument that we need to support what the RTAS is doing to support
> other hypervisors seems to be a fallacy.  What the RTAS is doing is
> not sane from a hardware standpoint, so I do not expect it from other
> virtualized/hypervisor style environments. 
> 
> If the hardware provides capabilities to isolate the MSI messages
> properly it does not need to prevent us from touching the msi setup
> registers.

I disagree, I think you will find more systems, not less of them,
doing something like RTAS.  And as I stated in another email I
believe sparc64 behaves the same way as RTAS.

Account for these systems now, they exist and we need to support
them properly.  It's not a one-off kind of thing.
