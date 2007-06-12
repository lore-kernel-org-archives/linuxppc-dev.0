Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18030.15937.699275.958545@cargo.ozlabs.ibm.com>
Date: Tue, 12 Jun 2007 16:33:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: arnd@arndb.de
Subject: Re: [patch 02/10] powerpc: Move CONFIG_PPC64 into CPU selection
In-Reply-To: <20070611233353.734704855@arndb.de>
References: <20070611232824.489103547@arndb.de>
	<20070611233353.734704855@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arnd@arndb.de writes:

> Currently, PPC64 is a top level configuration option in
> arch/powerpc/Kconfig, which is somewhat unconventional.

It makes a lot of sense to me to have 32 vs. 64 bits as a high level
binary selector that conditions the things that follow.  I don't think
it makes sense to push it down into the CPU selection menu.

Paul.
