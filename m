Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvgsX5RXSzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 23:33:52 +1100 (AEDT)
In-Reply-To: <1489147052-9590-1-git-send-email-vipin@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [v4] powernv/sensor: Handle OPAL_WRONG_STATE error return
Message-Id: <3vvgsX4dDGz9s2P@ozlabs.org>
Date: Fri, 31 Mar 2017 23:33:52 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-10 at 11:57:32 UTC, Vipin K Parashar wrote:
> OPAL returns OPAL_WRONG_STATE upon failing to provide
> sensor data due to core sleeping/offline. Added check
> in opal_get_sensor_data() for sensor read failure with
> OPAL_WRONG_STATE return code and returned -EIO.
> 
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/17bb69515c6dfbe282e8a9df08ffb7

cheers
