Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17227.44943.714106.911471@cargo.ozlabs.ibm.com>
Date: Tue, 11 Oct 2005 22:26:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: merge progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have just pushed out a new pile of commits to the powerpc-merge tree
on kernel.org.  (It may take a little while for them to get mirrored
from master.kernel.org to ftp/rsync.kernel.org.)

The current state is that with ARCH=ppc, the merge tree will build all
the ppc32 configs that build in the stock 2.6.14-rc2 tree, and the
powermac configs run (I haven't boot-tested any of the others).

With ARCH=powerpc, a 32-bit powermac target builds (both UP and SMP)
and runs, and a 64-bit pSeries target builds and runs.  64-bit iSeries
builds but there is some weird bug that Stephen Rothwell and BenH have
been chasing.  I haven't got far enough with the merge to be able to
build a 64-bit powermac target.

With ARCH=ppc64, pSeries, iSeries, powermac and maple all build, and
pSeries and iSeries have been boot-tested.  I think I have broken
BPA/cell because it was using pSeries_smp.c (I think we need to make
cell have its own bpa_smp.c or whatever anyway).

I have about a week's backlog of mail, resulting from being on
vacation last week and from concentrating on pushing the merge along.
Tomorrow I'll hopefully get a chance to look at all the patches people
have sent in the last week. :)

Paul.
