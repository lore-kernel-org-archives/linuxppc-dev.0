Return-Path: <miltonm@bga.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e53c7a64d7260d56983e22360cb5dd5a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/20] [powerpc] Remove linux,pci-domain properties
Date: Tue, 4 Jul 2006 02:55:50 -0500
To: Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue Jul 4 16:47:18 EST 2006, Jeremy Kerr wrote:
> The linux,pci-domain property is no longer used by DLPAR/PCI Hotplug
> utilites, or LSVPD. This change removes it.

So if I have some device-tree path and want to find the sysfs node
for it or run something like lspci on it, I have to search all of
sysfs for a matching devspec file?  (And this can change each boot.)

Without looking at the mentioned utilities, DLPAR and PCI Hotplug get a 
location code, so I'm hoping that the pci slot name is identified by 
that.  Is lsvpd scanning?  Or does it scan sysfs first and 
/proc/device-tree secondarly?

milton
