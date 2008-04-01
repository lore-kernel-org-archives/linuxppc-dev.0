Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18417.45926.65587.820132@cargo.ozlabs.ibm.com>
Date: Tue, 1 Apr 2008 15:00:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Add idle power save for ppc 4xx
In-Reply-To: <20080331130518.2a6b0264@zod.rchland.ibm.com>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
	<20080331130518.2a6b0264@zod.rchland.ibm.com>
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer writes:

> Actually, you probably don't want this as a property in the device
> tree.  It doesn't describe hardware.  A Kconfig option might be
> warranted though.

In general it is valid to have properties in the device tree that
describe the hypervisor or the kernel's interface to it, since they
are aspects of the platform, i.e. the virtual "hardware" that the
kernel is running on.

Paul.
