Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AFE13DE357
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 07:57:28 +1100 (EST)
Date: Fri, 26 Jan 2007 10:27:42 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
Message-ID: <20070126172742.GB22275@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<20070126065613.GB328@colo.lackof.org>
	<B75FCFBF-E92D-4283-A6BF-96517CE77C94@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B75FCFBF-E92D-4283-A6BF-96517CE77C94@kernel.crashing.org>
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 26, 2007 at 09:57:48AM +0100, Segher Boessenkool wrote:
> >>You code appears to be nice simple clean and to not support MSI in
> >>a useful way.  I may be reading too quickly but at the moment your
> >>infrastructure appears useless if you are on a platform that doesn't
> >>enforce MSI's get filtered with a legacy interrupt controller.
> >
> >Hrm?
> >Isn't the point of MSI to avoid any sort of interrupt controller?
> 
> No, the point of MSI is that it travels in the normal data
> stream (and stays ordered with it).  In the end it *has* to
> touch an interrupt controller (maybe the CPU-internal one).

Yes, sorry. I thinking about the properties of a "legacy interrupt
controller" and didn't intend that to mean the physical device:
    out-of-band delivery
    each IRQ line routed to one CPU on the motherboard,
    one IRQ line per device.

thanks,
grant
