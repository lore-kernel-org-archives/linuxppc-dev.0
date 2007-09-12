Return-Path: <akpm@linux-foundation.org>
Date: Wed, 12 Sep 2007 01:35:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 01/15] Extract the file descriptor search logic in SPU
	coredump code
Message-Id: <20070912013513.08678a30.akpm@linux-foundation.org>
In-Reply-To: <200709121817.43263.jk@ozlabs.org>
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
	<200709121817.43263.jk@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 12 Sep 2007 18:17:42 +1000 Jeremy Kerr <jk@ozlabs.org> wrote:

> This series looks good to me, thanks for the fixes. I'll do some testing 
> tomorrow but it looks like it'll be fine as-is.
> 
> Andrew - almost all of these are for spufs, the notable exception being:
> 
>  [PATCH 12/15] Cleanup ELF coredump extra notes logic
> 
> which touches the generic elf/coredump path.
> 
> Are you ok for me to merge this to my spufs tree, and upstream via 
> paulus?

Sure.  I'd only get in the way with spufs stuff.
