Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 442031A05EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 06:45:15 +1100 (AEDT)
Date: Mon, 07 Dec 2015 14:45:09 -0500 (EST)
Message-Id: <20151207.144509.1306012254991614677.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, nguyendo@us.ibm.com, jallen@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] Driver for IBM System i/p VNIC protocol
From: David Miller <davem@davemloft.net>
In-Reply-To: <5665D4D8.7010206@linux.vnet.ibm.com>
References: <1449251386-13476-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <20151205.222551.512793392902323297.davem@davemloft.net>
 <5665D4D8.7010206@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Mon, 7 Dec 2015 12:50:00 -0600

> Hi. Thanks for you feedback.  Could you clarify on what constitutes
> basic operation?  I just want to be sure if we should remove the
> other module parameters or just this one in particular?

With very minute exceptions, there should be no driver modules.

If a facility does not exist for run time configuration via ethtool
or similar, extend those facilities to suit your needs.
