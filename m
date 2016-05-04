Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0Y0B1Z67zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 08:40:26 +1000 (AEST)
In-Reply-To: <1461822825-21542-1-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: powerpc/pseries: Add null property check to pseries_discover_pic()
Message-Id: <3r0Y0B0j2jz9t5c@ozlabs.org>
Date: Thu,  5 May 2016 08:40:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-28-04 at 05:53:45 UTC, Suraj Jitindar Singh wrote:
> The return value of of_get_property() isn't checked before it is passed
> to the strstr() function, if it happens that the return value is null
> then this will result in a null pointer being dereferenced.
> 
> Add a check to see if the return value of of_get_property() is null and
> if it is continue straight on to the next node.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Chris Smart <chris@distroguy.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9ed3f7bcab00c9477e382e6589

cheers
