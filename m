Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18096.24918.111376.805855@cargo.ozlabs.ibm.com>
Date: Wed, 1 Aug 2007 20:32:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.23-rc1-mm2
In-Reply-To: <200708011002.30962.m.kozlowski@tuxland.pl>
References: <20070731230932.a9459617.akpm@linux-foundation.org>
	<200708011002.30962.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	gregkh@suse.de, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mariusz Kozlowski writes:

> Second issue as reported earilier allmodconfig fails to build on imac g3.

Do you really mean g3?  If so it's a 32-bit kernel and it shouldn't be
building lparmap.s.  Or do you mean G5?

>   CC      arch/powerpc/kernel/lparmap.s
>   AS      arch/powerpc/kernel/head_64.o
> lparmap.c: Assembler messages:
> lparmap.c:84: Error: file number 1 already allocated
> make[1]: *** [arch/powerpc/kernel/head_64.o] Blad 1
> make: *** [arch/powerpc/kernel] Blad 2

Weird.  Could you do make V=1 and send me the output?

Paul.
