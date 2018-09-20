Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3ST3y0pzF37B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:20:57 +1000 (AEST)
In-Reply-To: <1534250715-4543-1-git-send-email-clombard@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V3] ocxl: Fix access to the AFU Descriptor Data
Message-Id: <42G3ST1F03z9sCR@ozlabs.org>
Date: Thu, 20 Sep 2018 14:20:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-14 at 12:45:15 UTC, Christophe Lombard wrote:
> The AFU Information DVSEC capability is a means to extract common,
> general information about all of the AFUs associated with a Function
> independent of the specific functionality that each AFU provides.
> Write in the AFU Index field allows to access to the descriptor data
> for each AFU.
> 
> With the current code, we are not able to access to these specific data
> when the index >= 1 because we are writing to the wrong location.
> All requests to the data of each AFU are pointing to those of the AFU 0,
> which could have impacts when using a card with more than one AFU per
> function.
> 
> This patch fixes the access to the AFU Descriptor Data indexed by the
> AFU Info Index field.
> 
> Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
> Cc: stable <stable@vger.kernel.org>     # 4.16
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6f8e45f7eb1bee5efdbe4a9cfe4a45

cheers
