Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C114DDEEA
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 15:29:28 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
References: <m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<17850.33971.762011.194195@cargo.ozlabs.ibm.com>
	<m18xfpuqyp.fsf@ebiederm.dsl.xmission.com>
	<20070126.190216.95060896.davem@davemloft.net>
Date: Fri, 26 Jan 2007 21:28:52 -0700
In-Reply-To: <20070126.190216.95060896.davem@davemloft.net> (David Miller's
	message of "Fri, 26 Jan 2007 19:02:16 -0800 (PST)")
Message-ID: <m1tzydt7nf.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: grundler@parisc-linux.org, greg@kroah.com, kyle@parisc-linux.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, brice@myri.com,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller <davem@davemloft.net> writes:

>
> Interesting.
>
> This is exactly how all sparc64 chips have always worked too.  On
> sparc64 the cpu can actually read in the packets and process them.
> Can the x86 interrupt handler get at the full packet data?

I wish.  All it can get is a single byte of the packet, for selecting
what to do.  The rest of the information encodes irq type and which cpu
to send interrupt to.

Eric
