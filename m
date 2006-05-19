Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17517.20729.170817.242398@cargo.ozlabs.ibm.com>
Date: Fri, 19 May 2006 15:00:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH] remove powerpc bitops infavor of existing generic bitops
In-Reply-To: <20060515180108.GB17646@us.ibm.com>
References: <20060515180108.GB17646@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Mason writes:

> There already exists a big endian safe bitops implementation in
> lib/find_next_bit.c.  The code in it is 90%+ common with the powerpc
> specific version, so the powerpc version is redundant.  This patch
> makes the necessary changes to use the generic bitops in powerpc, and
> removes the powerpc specific version.

This patch breaks ARCH=ppc builds.  Please resubmit with the necessary
changes to arch/ppc/Kconfig as well.

Paul.
