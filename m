Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgJvD20J6zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 22:36:40 +1000 (AEST)
In-Reply-To: <1467171519-19882-2-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: robh@kernel.org, arnd@arndb.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulus@samba.org, sjitindarsingh@gmail.com
Subject: Re: [V5,
 2/3] powerpc/opal: Add inline function to get rc from an ASYNC_COMP
 opal_msg
Message-Id: <3rgJvD18wYz9t0V@ozlabs.org>
Date: Thu, 30 Jun 2016 22:36:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-29-06 at 03:38:38 UTC, Suraj Jitindar Singh wrote:
> An opal_msg of type OPAL_MSG_ASYNC_COMP contains the return code in the
> params[1] struct member. However this isn't intuitive or obvious when
> reading the code and requires that a user look at the skiboot
> documentation or opal-api.h to verify this.
> 
> Add an inline function to get the return code from an opal_msg and update
> call sites accordingly.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d0226d315dba5e401a124b394a

cheers
