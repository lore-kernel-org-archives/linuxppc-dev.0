Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A466E1A08BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 20:14:04 +1100 (AEDT)
In-Reply-To: <1450682917-24913-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/opal: fix minor off-by-one error in
 opal_mce_check_early_recovery()
Message-Id: <20160111091404.3D24714031C@ozlabs.org>
Date: Mon, 11 Jan 2016 20:14:04 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-21-12 at 07:28:37 UTC, Andrew Donnellan wrote:
> Fix off-by-one error in opal_mce_check_early_recovery() when checking
> whether the NIP falls within OPAL space.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dc3799bb9ab2666fa19081121f

cheers
