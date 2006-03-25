Return-Path: <greg@kroah.org>
Received: from aria.kroah.org (dsl093-040-174.pdx1.dsl.speakeasy.net
	[66.93.40.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5BFD667A3F
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 13:50:21 +1100 (EST)
Date: Fri, 24 Mar 2006 18:22:06 -0800
From: Greg KH <greg@kroah.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] PCI Error Recovery: e1000 network device driver
Message-ID: <20060325022206.GA6361@kroah.com>
References: <20060324220002.GC26137@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060324220002.GC26137@austin.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jesse.brandeburg@intel.com, linuxppc-dev@ozlabs.org,
	john.ronciak@intel.com, jeffrey.t.kirsher@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 24, 2006 at 04:00:02PM -0600, Linas Vepstas wrote:
> +	/* Perform card reset only on one instance of the card */
> +	if(0 != PCI_FUNC (pdev->devfn))
> +		return PCI_ERS_RESULT_RECOVERED;

You seem to have forgotton to put a ' ' after the 'if' in a number of
different places in this patch.  Also the (0 != foo) form is a bit
different from the traditional kernel coding style.

> +	switch(adapter->hw.mac_type) {

And here too.

Remember, "if" and "switch" are not functions...

thanks,

greg k-h
