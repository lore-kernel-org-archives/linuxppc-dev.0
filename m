Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80DC368963
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 07:31:00 +1100 (EST)
Date: Thu, 29 Dec 2005 18:31:11 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20051229203111.GC9203@dmt.cnet>
References: <43B2EFD0.4010709@ru.mvista.com> <20051229194014.GC8842@dmt.cnet>
	<43B43EE4.6010900@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43B43EE4.6010900@secretlab.ca>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/2] ppc32: Make platform devices being able to assign
	functions (resend)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 29, 2005 at 12:54:12PM -0700, Grant Likely wrote:
> Marcelo Tosatti wrote:
> > Hi Vitaly,
> > 
> > On Wed, Dec 28, 2005 at 11:04:32PM +0300, Vitaly Bordug wrote:
> > 
> >>Implemented by  modification of the .name field of the platform device,
> >>when PDs with the
> >>same names are to be used within different drivers, as
> >><device_name> -> <device_name>:<function>
> >>Corresponding drivers should change the .name in struct device_driver to
> >>reflect upper of course.
> > 
> > 
> > I'm not certain that the <device_name>:<function> structure for sysfs   
> > representation is "allowed" - have you asked GregKH about it?
> > 
> >
> He didn't seem to have any problem with it when we talked about it at
> OLS.  Also, ':' is already used by the PCI bus driver.  Look in
> /sys/class/pci_bus.

Fine then, thanks Grant.
