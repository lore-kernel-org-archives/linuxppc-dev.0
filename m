Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-39.bluehost.com (outbound-mail-39.bluehost.com
	[69.89.20.193]) by ozlabs.org (Postfix) with SMTP id 88266DDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 10:34:22 +1000 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] hotplug/rpaphp: remove unused error path code
Date: Wed, 27 Aug 2008 16:34:03 -0700
References: <20080819114555.c0d2bd50.sfr@canb.auug.org.au>
In-Reply-To: <20080819114555.c0d2bd50.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808271634.06199.jbarnes@virtuousgeek.org>
Cc: Alex Chiang <achiang@hp.com>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Linda Xie <lxie@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday, August 18, 2008 6:45 pm Stephen Rothwell wrote:
> Commit f46753c5e354b857b20ab8e0fe7b2579831dc369 ("PCI: introduce pci_slot")
> removed the need for this error path.  Eliminate this warning:
>
> drivers/pci/hotplug/rpaphp_slot.c: In function 'rpaphp_register_slot':
> drivers/pci/hotplug/rpaphp_slot.c:151: warning: label 'sysfs_fail' defined
> but not used
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied to linux-next, thanks.

Jesse
