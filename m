Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00B37DDF50
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 08:56:23 +1000 (EST)
Message-Id: <F50B6A57-91C7-4023-926B-1288F7146592@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0804231749530.14182@blarg.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Please pull from 'powerpc-next' branch
Date: Wed, 23 Apr 2008 17:56:17 -0500
References: <Pine.LNX.4.64.0804231749530.14182@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here are four patches posted for you to pick up directly:

[POWERPC v7] 85xx: Add support for relocatble kernel (and booting at  
non-zero)
[POWERPC v2] Port fixmap from x86 and use for kmap_atomic
[POWERPC] Cleanup asm-offset.c
[POWERPC] Clean up access to thread_info in assembly

- k
