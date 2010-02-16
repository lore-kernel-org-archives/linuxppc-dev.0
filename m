Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31F42B7CB9
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 15:18:59 +1100 (EST)
Date: Mon, 15 Feb 2010 22:16:03 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/6] powerpc: Use lwarx hint in spinlocks
Message-ID: <20100216041603.GA12167@lixom.net>
References: <20100210105728.GA3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100210105728.GA3399@kryten>
Cc: npiggin@suse.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2010 at 09:57:28PM +1100, Anton Blanchard wrote:

> v2: We do this only for 64bit until we can verify all 32bit CPUs.
> 
> Tested so far: 970 (thanks Ben), POWER5, POWER6, POWER7
> Still to test: RS64, POWER3, POWER4

Tested on PA6T as well, no performance impact (as expected).


-Olof
