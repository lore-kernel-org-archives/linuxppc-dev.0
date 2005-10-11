Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Tue, 11 Oct 2005 20:54:51 +0200
References: <17227.44943.714106.911471@cargo.ozlabs.ibm.com>
In-Reply-To: <17227.44943.714106.911471@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510112054.52348.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: merge progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Dinsdag 11 Oktober 2005 14:26, Paul Mackerras wrote:
> With ARCH=ppc64, pSeries, iSeries, powermac and maple all build, and
> pSeries and iSeries have been boot-tested.  I think I have broken
> BPA/cell because it was using pSeries_smp.c (I think we need to make
> cell have its own bpa_smp.c or whatever anyway).

I will fix that up when I move BPA over to arch/powerpc/platforms/cell.

Do you plan to have the whole merge tree included in 2.6.15? Otherwise
I'd rather postpone doing the structural changes on BPA until November,
because we're currently freezing our spufs development to 2.6.14 and
I'd like to have only one current set of big patches.

	Arnd <><
