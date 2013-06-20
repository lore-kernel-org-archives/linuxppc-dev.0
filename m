Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E120D2C045D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 20:29:28 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 04:18:35 -0600
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 08A016E8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 06:18:29 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5KAHgvZ44695790
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 06:17:42 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5KAHfB3002571
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 06:17:41 -0400
Date: Thu, 20 Jun 2013 18:17:38 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 0/5] EEH Support for PowerNV platform
Message-ID: <20130620101738.GA14545@shangw.(null)>
References: <1371723206-26190-1-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371723206-26190-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 20, 2013 at 06:13:21PM +0800, Gavin Shan wrote:
>
>It resends the last 5 patches ([27/31] - [31/31]) of the series to support EEH
>for PowerNV platform.
>
>v6 -> v7:
>	* Use atomic notifier to replace the original OPAL notifier according
>	  to Ben's suggestion.
>	* Avoid registering duplicated notifiers for OPAL_EVENT_PCI_ERROR.
>

It also fixes the problem pointed by Mikey:

	* Included <asm/debug.h> in pci-ioda.c for correct reference to
	  "powerpc_debugfs_root".

Thanks,
Gavin
