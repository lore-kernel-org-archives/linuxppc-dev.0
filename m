Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCADEDDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 14:26:17 +1100 (EST)
Date: Tue, 13 Nov 2007 19:26:07 -0800
From: Greg KH <greg@kroah.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] pci hotplug: fix rpaphp directory naming
Message-ID: <20071114032607.GA22438@kroah.com>
References: <20071114003455.GD8509@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071114003455.GD8509@austin.ibm.com>
Cc: rick.jones2@hp.com, pcihpd-discuss@lists.sourceforge.net,
	Alex Chiang <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>,
	gregkh@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-acpi@vger.kernel.org,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, strosake@us.ibm.com, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 13, 2007 at 06:34:55PM -0600, Linas Vepstas wrote:
> 
> 
> Fix presentation of the slot number in the /sys/bus/pci/slots
> directory to match that used in the majority of other drivers.

We need a signed-off-by: to be able to apply this...

thanks,

greg k-h
