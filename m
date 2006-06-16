Return-Path: <anton@ozlabs.org>
Date: Fri, 16 Jun 2006 10:14:16 +1000
From: Anton Blanchard <anton@samba.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] powerpc: Fix 64k pages on non-partitioned machines
Message-ID: <20060616001416.GD15141@krispykreme>
References: <17553.16736.157418.936815@cargo.ozlabs.ibm.com>
	<200606151508.46613.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200606151508.46613.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Arnd,

> Actually, I thought we decided to postpone 64k page support on cell
> to 2.6.18 already. This patch alone is not enough to make it work,
> at least one more fix is needed for being able to boot, while
> the spu file system needs major changes for it.

We are hitting the bug on other ppc64 systems too, so I think its worth
fixing for 2.6.17.

Anton
