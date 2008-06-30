Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18536.25052.228270.743669@cargo.ozlabs.ibm.com>
Date: Mon, 30 Jun 2008 14:32:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 08/18 v2] powerpc: Do not probe PCI buses or eBus devices
	if CMO is enabled
In-Reply-To: <20080625201721.GJ17020@linux.vnet.ibm.com>
References: <20080625201202.GB17020@linux.vnet.ibm.com>
	<20080625201721.GJ17020@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Jennings writes:

> From: Brian King <brking@linux.vnet.ibm.com>
> 
> The Cooperative Memory Overcommit (CMO) on System p does not currently
> support native PCI devices or eBus devices when enabled.

Then why would we get any native PCI or eBus devices in the device
tree?

Paul.
