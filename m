Return-Path: <anton@ozlabs.org>
Date: Wed, 17 Feb 2010 20:37:14 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH 1/6] powerpc: Use lwarx hint in spinlocks
Message-ID: <20100217093714.GB24270@kryten>
References: <20100210105728.GA3399@kryten>
 <20100211065617.GA6735@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100211065617.GA6735@laptop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Nick,

> Cool. How does it go when there are significant amount of instructions
> between the lock and the unlock? A real(ish) workload, like dbench on
> ramdisk (which should hit the dcache lock).

Good question, I'll see if we can see a difference on dbench.

Anton
