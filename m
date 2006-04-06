Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 2C33167B21
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2006 08:50:02 +1000 (EST)
Date: Thu, 6 Apr 2006 15:46:43 -0700
From: Greg KH <greg@kroah.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] PCI Error Recovery: e100 network device driver
Message-ID: <20060406224643.GA6278@kroah.com>
References: <20060406222359.GA30037@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060406222359.GA30037@austin.ibm.com>
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

On Thu, Apr 06, 2006 at 05:24:00PM -0500, Linas Vepstas wrote:
> +	if(pci_enable_device(pdev)) {

Add a space after "if" and before "(" please.

You do this in a few different places.

thanks,

greg k-h
