Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqX0WtTzF1s5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:44 +1000 (AEST)
In-Reply-To: <1525688738-9185-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux@roeck-us.net
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-hwmon@vger.kernel.org, stewart@linux.vnet.ibm.com, jdelvare@suse.com,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [3/3] hwmon: (ibmpowernv) Add energy sensors
Message-Id: <40skqW5Xm4z9s2k@ozlabs.org>
Date: Fri, 25 May 2018 21:41:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-07 at 10:25:38 UTC, Shilpasri G Bhat wrote:
> This patch exports the accumulated power numbers of each power
> sensor maintained by OCC.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/43d2974b66d916a6df16e536da542e

cheers
