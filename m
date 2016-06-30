Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgJvB4Sz8zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 22:36:38 +1000 (AEST)
In-Reply-To: <1467171519-19882-1-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: robh@kernel.org, arnd@arndb.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulus@samba.org, sjitindarsingh@gmail.com
Subject: Re: [V5,
 1/3] devicetree/bindings: Add binding for operator panel on FSP
 machines
Message-Id: <3rgJvB3kh5z9t0G@ozlabs.org>
Date: Thu, 30 Jun 2016 22:36:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-29-06 at 03:38:37 UTC, Suraj Jitindar Singh wrote:
> Add a binding to Documentation/devicetree/bindings/powerpc/opal
> (oppanel-opal.txt) for the operator panel which is present on IBM
> Power Systems machines with FSPs.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1ae88fd54c3ac31f68f91e37f7

cheers
