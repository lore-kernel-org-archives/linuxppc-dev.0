Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 87F47B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 07:48:27 +1100 (EST)
Message-ID: <1332362899.2982.40.camel@pasglop>
Subject: Re: [PATCH] Disable /dev/port interface on powerpc systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2012 07:48:19 +1100
In-Reply-To: <1332356284.13004.9.camel@hbabu-laptop>
References: <1332308237.23222.49.camel@hbabu-laptop>
 <1332314613.2982.38.camel@pasglop> <1332356284.13004.9.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-03-21 at 11:58 -0700, Haren Myneni wrote:
> 
> Yes, can be changed open or read/write calls and return -ENODEV,
> but /dev/port is no use on these systems.
> 
> I am not sure whether any power systems have legacy ISA devices. If we
> do not have, CONFIG_DEVPORT can be disabled in Kconfig. 

Dome do, older ones mostly.

Cheers,
Ben.
