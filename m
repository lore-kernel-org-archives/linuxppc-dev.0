Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 91D641A0D05
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 06:34:15 +1000 (AEST)
Date: Thu, 30 Apr 2015 16:34:12 -0400 (EDT)
Message-Id: <20150430.163412.1826906094049118756.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Subject: Re: [PATCH net-next v3 2/4] ibmveth: Add support for TSO
From: David Miller <davem@davemloft.net>
In-Reply-To: <1430342747-16774-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1430342747-16774-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <1430342747-16774-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: brking@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, eric.dumazet@gmail.com,
 nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Wed, 29 Apr 2015 16:25:45 -0500

> Add support for TSO.  TSO is turned off by default and
> must be enabled and configured by the user.  The driver
> version number is increased so that users can be sure
> that they are using ibmveth with TSO support.
> 
> Cc: Brian King <brking@linux.vnet.ibm.com>
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> ---
> v2: Included statistics that were previously in a separate patch

Applied.
