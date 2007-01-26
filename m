Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17850.33971.762011.194195@cargo.ozlabs.ibm.com>
Date: Sat, 27 Jan 2007 09:46:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
In-Reply-To: <m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eric W. Biederman writes:

> I believe the ppc model is to allocate an interrupt source on their
> existing interrupt controller and use that instead of the normal x86
> case of having the MSI interrupt go transparently to the cpu.

Do you mean that x86 cpus themselves can actually be the target of a
write on the bus?  That's the first time I've heard of the CPU itself
being a target for a bus operation.

Or do you mean there is some piece of hardware in the northbridge (or
elsewhere) that accepts the MSI message writes and asserts an
interrupt line to the CPU?  That is basically what we have on PPC.

Paul.
