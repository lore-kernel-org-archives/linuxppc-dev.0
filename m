Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AE491A198F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 20:42:01 +1000 (AEST)
In-Reply-To: <20150708062702.11242.47257.stgit@localhost.localdomain>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 jk@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: neelegup@linux.vnet.ibm.com
Subject: Re: ipmi/powernv: Fix a minor bug
Message-Id: <20150708104201.52B3D140AF3@ozlabs.org>
Date: Wed,  8 Jul 2015 20:42:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-08-07 at 06:27:28 UTC, Neelesh Gupta wrote:
> If the OPAL call to receive the ipmi message fails, then we free up the smi
> message before returning. But, the driver still holds the reference to old
> smi message in the 'cur_msg' which is dangerous if the driver derefernces it
> later and it will further block the subsequent ipmi operations. 

This doesn't sound like "a minor bug" ?

What are the actual symptoms of the bug? Does it crash, always, sometimes? Does
it actually "block the subsequent ipmi operations"?

Even if this *is* a minor bug, please give it a proper subject that describes
what it does.

Also which commit introduced the bug?

And finally you don't seem to have CC'ed the ipmi maintainers?

cheers
