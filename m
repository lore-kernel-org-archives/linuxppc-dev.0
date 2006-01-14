Return-Path: <flar@pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) by ozlabs.org (Postfix) with ESMTP id 7AE40681BD
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jan 2006 07:02:44 +1100 (EST)
Date: Sat, 14 Jan 2006 11:31:58 -0800
From: Brad Boyer <flar@allandria.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Remove powermac support from ARCH=ppc
Message-ID: <20060114193158.GA5818@pants.nu>
References: <17352.57423.119068.737164@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17352.57423.119068.737164@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 14, 2006 at 10:28:15PM +1100, Paul Mackerras wrote:
> This means, BTW, that it will no longer be possible to build 32-bit
> kernels for Apple G5 machines.  Also, miboot users (are there any
> still?) are out of luck until I move the miboot stuff over to
> arch/powerpc/boot.

If nothing else, miboot is used to make install floppies for oldworld
boxes for the Debian installer. I doubt very many people are using it
for normal boot, but this is the simplest way to boot from a floppy
disk on oldworld models.

	Brad Boyer
	flar@allandria.com
