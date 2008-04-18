Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42126DE617
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 18:18:28 +1000 (EST)
Subject: Re: [PATCH 2/3] [POWERPC] Fix kernel stack allocation alignment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080418000618.0c46c78f.akpm@linux-foundation.org>
References: <20080418065727.5FE1CDE247@ozlabs.org>
	<20080418000618.0c46c78f.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 18:18:18 +1000
Message-Id: <1208506698.6958.400.camel@pasglop>
Mime-Version: 1.0
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> so...  the "0" defeats all of SLAB_DEBUG_FREE, SLAB_RED_ZONE, SLAB_POISON
> and SLAB_STORE_USER, if the comment in slab.h is to be believed.
> 
> Was that overkill?

Well, I copied over from something else, looks like there's a -lot- of 0
users here... 

Shouldn't there be some kind of SLAB_DEFAULT that contain those things ?

Ben.
