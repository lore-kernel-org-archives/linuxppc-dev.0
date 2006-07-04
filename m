Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/20] [powerpc] Remove linux,pci-domain properties
Date: Wed, 5 Jul 2006 09:22:18 +1000
References: <e53c7a64d7260d56983e22360cb5dd5a@bga.com>
In-Reply-To: <e53c7a64d7260d56983e22360cb5dd5a@bga.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607050922.19779.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton,

> Without looking at the mentioned utilities, DLPAR and PCI Hotplug get
> a location code, so I'm hoping that the pci slot name is identified
> by that.  Is lsvpd scanning?  Or does it scan sysfs first and
> /proc/device-tree secondarly?

Yes, lsvpd scans sysfs first, then uses devspec to refer to the device 
tree. and AFAICT, the slot id can't be extracted from the location 
code.

So you're saying that the linux,pci-domain property is still in use, 
right? If so, I'll do up a patch to fix add_linux_pci_domain rather 
than removing it.

Cheers,


Jeremy
