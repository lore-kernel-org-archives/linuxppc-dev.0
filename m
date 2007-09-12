Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 01/15] Extract the file descriptor search logic in SPU
	coredump code
Date: Wed, 12 Sep 2007 18:17:42 +1000
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
In-Reply-To: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200709121817.43263.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Michael,

This series looks good to me, thanks for the fixes. I'll do some testing 
tomorrow but it looks like it'll be fine as-is.

Andrew - almost all of these are for spufs, the notable exception being:

 [PATCH 12/15] Cleanup ELF coredump extra notes logic

which touches the generic elf/coredump path.

Are you ok for me to merge this to my spufs tree, and upstream via 
paulus?

Cheers,


Jeremy
