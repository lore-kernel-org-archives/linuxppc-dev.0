Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQDtZ47qQzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 15:50:46 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 9 Jun 2016 01:50:44 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH, RFC] cxl: Add support for CAPP DMA mode
In-Reply-To: <1465362594-10437-1-git-send-email-imunsie@au.ibm.com>
References: <1464025158-23849-1-git-send-email-imunsie@au.ibm.com>
 <1465362594-10437-1-git-send-email-imunsie@au.ibm.com>
Date: Thu, 09 Jun 2016 15:49:51 +1000
Message-ID: <87vb1ihpxc.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian Munsie <imunsie@au1.ibm.com> writes:

> From: Ian Munsie <imunsie@au1.ibm.com>
>
> This adds support for using CAPP DMA mode, which is required for XSL
> based cards such as the Mellanox CX4 to function.
>
> This is currently an RFC as it depends on the corresponding support to
> be merged into skiboot first, which was submitted here:
> http://patchwork.ozlabs.org/patch/625582/

Merged to skiboot as of 5477148a439fda9fb55ea4a828c958fcdcc10f2e - which
will make it into skiboot 5.3.x

-- 
Stewart Smith
OPAL Architect, IBM.
