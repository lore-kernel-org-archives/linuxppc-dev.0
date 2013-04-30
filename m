Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 605332C00C8
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Apr 2013 11:08:33 +1000 (EST)
Message-ID: <1367284092.7288.55.camel@pasglop>
Subject: Re: [PATCH] powerpc: fix usage of setup_pci_atmu()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 30 Apr 2013 11:08:12 +1000
In-Reply-To: <20130430090636.5e06bbfc6db472e1e677cb0b@canb.auug.org.au>
References: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
 <5881.1366004521@ale.ozlabs.ibm.com>
 <20130430090636.5e06bbfc6db472e1e677cb0b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-30 at 09:06 +1000, Stephen Rothwell wrote:

> 
> This is still not in your tree ...

I'll apply it after I merge kumar stuff.

Cheers,
Ben.
