Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20051001001005.348d7798.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
	<20051001001005.348d7798.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <27c25b49c3f8c5d3f563a0b9b39bda8c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Sun, 2 Oct 2005 03:06:04 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 8/9] powerpc: make iSeries build
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The merge of vmlinux.lds.S would be much cleaner if it is clear that
> putting the ..start/end symbols inside the section definitions is OK on
> ppc32.

It is okay, and putting those symbol definitions
outside the section definition (like the ppc32
linker script used to do) can be wrong even, for
example, when the output sections need extra
alignment.


Segher
