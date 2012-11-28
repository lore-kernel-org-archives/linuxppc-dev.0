Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5CFF52C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 15:28:56 +1100 (EST)
Message-ID: <1354076916.2179.99.camel@pasglop>
Subject: Re: linux-next: build failure after merge of the powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 28 Nov 2012 15:28:36 +1100
In-Reply-To: <20121128140308.abb21ec8f61553a2ed077fe3@canb.auug.org.au>
References: <20121128140308.abb21ec8f61553a2ed077fe3@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Ashley Lai <adlai@linux.vnet.ibm.com>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-11-28 at 14:03 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc tree, next-20121115's build (powerpc
> allmodconfig) failed like this:
> 
> ERROR: ".of_reconfig_notifier_register" [drivers/crypto/nx/nx-compress.ko] undefined!
> ERROR: ".of_reconfig_notifier_unregister" [drivers/crypto/nx/nx-compress.ko] undefined!
> 
> Caused by commit 1cf3d8b3d24c ("powerpc+of: Add of node/property
> notification chain for adds and removes").

That nx stuff should just have gone through the powerpc tree... that's
not the first time it trips on generic changes because we miss it
being in the crypto tree...

Ashley, Nathan, who owns that ? Can you come up with a fixup patch ?

Ben.
