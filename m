Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18039.31697.402356.570828@cargo.ozlabs.ibm.com>
Date: Tue, 19 Jun 2007 16:46:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 23/33] powerpc: Localize mmu_off
In-Reply-To: <46730D5B.300@am.sony.com>
References: <20070615204749.629571012@am.sony.com> <46730D5B.300@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> This just removes the dependency __mmu_off has on the symbol
> __after_prom_start.  I found the current code inconvenient when I
> wanted to put some debugging code between the call to __mmu_off
> and the branch to __after_prom_start.

So we do an extra unnecessary branch...  I realize it doesn't really
matter, but on the other hand, if you're hacking around with debug
stuff, you can easily change __after_prom_start to the label where
your debug code starts.

Paul.
