Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgJv93N62zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 22:36:37 +1000 (AEST)
In-Reply-To: <1466687034-15350-1-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: Re: [v7,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
Message-Id: <3rgJv92lNSz9syB@ozlabs.org>
Date: Thu, 30 Jun 2016 22:36:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-23-06 at 13:03:53 UTC, Philippe Bergheaud wrote:
> This adds an afu_driver_ops structure with fetch_event() and
> event_delivered() callbacks. An AFU driver such as cxlflash can fill
> this out and associate it with a context to enable passing custom AFU
> specific events to userspace.
...
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b810253bd9342f863a86ec7dff

cheers
