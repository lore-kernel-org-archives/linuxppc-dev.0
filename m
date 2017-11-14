Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblGF5MQYzDqpp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:21 +1100 (AEDT)
In-Reply-To: <1510107838-15181-2-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, nicholas.piggin@gmail.com,
 linuxppc-dev@ozlabs.org
Subject: Re: [v3,01/18] powerpc/vas: init missing fields from [rt]xattr
Message-Id: <3yblGF0dbkz9t16@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-11-08 at 02:23:41 UTC, Sukadev Bhattiprolu wrote:
> Initialize a few missing window context fields from the window attributes
> specified by the caller. These fields are currently set to their default
> values by the caller (NX-842), but would be good to apply them anyway.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Patches 1-11, 13-14 and 16-18 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e34917fbee1226144c94413697ddbf

cheers
