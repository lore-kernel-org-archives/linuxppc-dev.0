Return-Path: <ruscur@russell.cc>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwJ7R5wSdzF1PF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 11:49:07 +1100 (AEDT)
Message-ID: <1520297342.2077.2.camel@russell.cc>
Subject: Re: [PATCH 3/9] powerpc/eeh: Fix misleading comment in
 __eeh_addr_cache_get_device()
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Mar 2018 11:49:02 +1100
In-Reply-To: <a08f33ca4af93b1a6ec066b8091953c855d52f45.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <a08f33ca4af93b1a6ec066b8091953c855d52f45.1520294174.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-06 at 10:59 +1100, Sam Bobroff wrote:
> Commit "0ba178888b05 powerpc/eeh: Remove reference to PCI device"
> removed a call to pci_dev_get() from __eeh_addr_cache_get_device()
> but
> did not update the comment to match.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>
