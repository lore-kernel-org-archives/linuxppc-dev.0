Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18592.55293.75051.615024@cargo.ozlabs.ibm.com>
Date: Tue, 12 Aug 2008 10:23:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: mohan@in.ibm.com
Subject: Re: [PATCH 3/5] Apply relocation
In-Reply-To: <20080811201547.GC26566@in.ibm.com>
References: <20080811201120.GA25283@in.ibm.com>
	<20080811201547.GC26566@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M writes:

> Apply relocation
> 
> This code is a wrapper around regular kernel. This checks whether the
> kernel is loaded at 32MB, if its not loaded at 32MB, its treated as a
> regular kernel and the control is given to the kernel immediately. If
> the kernel is loaded at 32MB, it applies relocation delta to each offset
> in the list which was generated and appended by patch 1 and 2. After
> updating all offsets, control is given to the relocatable kernel.
> 
> Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
> ---
>  arch/powerpc/boot/vmlinux.lds.S     |   28 ++++++++++++++++++++++++++++
>  arch/powerpc/boot/vmlinux.reloc.scr |    8 ++++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)

I think there is some stuff missing here...  This patch only adds two
linker scripts.

Paul.
